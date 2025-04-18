#!/bin/bash

# --- Configuration ---
AUDIO_DEVICE="plughw:0,7"     # Your recording device
MODEL="tiny"                # WhisperX model
COMPUTE_TYPE="float32"      # WhisperX compute type

# State files to manage the background process
PID_FILE="/tmp/voice_input.pid"
WAV_PATH_FILE="/tmp/voice_input.wavpath"
# Define a consistent temporary audio file name
TMP_AUDIO_FILE="/tmp/voice_input_recording.wav"
# --- End Configuration ---

# Function to clean up state files ONLY. Audio file handled separately.
cleanup_state_files() {
  rm -f "$PID_FILE" "$WAV_PATH_FILE"
}

# --- Action: Start Recording ---
if [ "$1" == "start" ]; then
    # Check if already recording
    if [ -f "$PID_FILE" ]; then
        # Check if the process listed in PID_FILE is actually running
        if ps -p "$(cat "$PID_FILE")" > /dev/null; then
             notify-send "Voice Input" "Already recording! Press F11 to stop." -u low
             exit 0 # Exit silently, maybe already running
        else
             # PID file exists, but process is dead. Clean up.
             cleanup_state_files
        fi
    fi

    # Notify user
    notify-send "Voice Input" "Recording STARTED. Press F11 to stop." -t 4000 # Show longer

    # Store the chosen audio file path
    echo "$TMP_AUDIO_FILE" > "$WAV_PATH_FILE"

    # Start arecord in the background, overwriting the temp file
    # Use exec to replace the shell process *within the subshell* for cleaner process management,
    # but this makes getting $! tricky. Let's stick to direct backgrounding.
    arecord -f S16_LE --device="$AUDIO_DEVICE" "$TMP_AUDIO_FILE" > /dev/null 2>&1 &

    # Store the PID of the arecord process
    ARECORD_PID=$!
    echo "$ARECORD_PID" > "$PID_FILE"

    # Optional: Monitor the process in case it dies unexpectedly
    # (This part makes the F10 press block until recording ends OR F11 is handled - might not be ideal)
    # Instead, rely on F11 to handle termination.

    exit 0
fi

# --- Action: Stop Recording & Transcribe ---
if [ "$1" == "stop" ]; then
    # Check if PID file exists
    if [ ! -f "$PID_FILE" ]; then
        notify-send "Voice Input" "No active recording found to stop." -u low
        exit 1
    fi

    # Read PID and Wav Path
    ARECORD_PID=$(cat "$PID_FILE")
    AUDIO_FILE=$(cat "$WAV_PATH_FILE")

    # Check if the process actually exists
    if ! ps -p "$ARECORD_PID" > /dev/null; then
        notify-send "Voice Input" "Recording process not found (already stopped?)." -u low
        # Still attempt transcription if the audio file exists
    else
        # Send SIGINT (Ctrl+C) to arecord to make it stop gracefully and finalize the file
        kill -SIGINT "$ARECORD_PID"
        notify-send "Voice Input" "Recording STOPPED. Processing..." -t 3000
        # Give it a moment to finish writing the file
        sleep 0.5
    fi

    # --- Transcription and Typing (Similar to previous script) ---

    # Check if audio file exists and has data
    if [ ! -s "$AUDIO_FILE" ]; then
         notify-send "Voice Input Error" "Audio file missing or empty. Cannot transcribe." -u critical
         cleanup_state_files # Clean up state files
         rm -f "$AUDIO_FILE" # Attempt to remove audio file if it exists but is empty
         exit 1
    fi

    # Use a temporary dir for whisperx output files
    OUTPUT_DIR=$(mktemp -d)
    trap 'rm -rf "$OUTPUT_DIR"' EXIT # Ensure whisperx output dir is cleaned up

    # Transcribe
    TRANSCRIPT=$(~/.venv/bin/whisperx \
                    --model "$MODEL" \
                    --compute_type "$COMPUTE_TYPE" \
                    --output_format txt \
                    --output_dir "$OUTPUT_DIR" \
                    "$AUDIO_FILE" 2>/dev/null)

    # Fallback: If stdout was empty, try reading the .txt file
    # if [ -z "$TRANSCRIPT" ]; then
        TXT_FILE=$(find "$OUTPUT_DIR" -maxdepth 1 -name '*.txt' -print -quit)
        if [ -f "$TXT_FILE" ]; then
            TRANSCRIPT=$(cat "$TXT_FILE")
        fi
    # fi

    # Trim whitespace
    TRANSCRIPT=$(echo "$TRANSCRIPT" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Type the text
    if [ -n "$TRANSCRIPT" ]; then
        if ! xdotool type --delay 10 "$TRANSCRIPT"; then
            notify-send "Voice Input Error" "Failed to type text using xdotool." -u critical
        else
            notify-send "Voice Input" "Text inserted." -t 2000
        fi
    else
        notify-send "Voice Input Error" "Transcription failed or produced no text." -u critical
    fi

    # --- Final Cleanup ---
    cleanup_state_files # Remove PID and Path files
    rm -f "$AUDIO_FILE" # Remove the temporary audio file
    # The trap will remove $OUTPUT_DIR

    exit 0
fi

# --- No/Invalid Action ---
echo "Usage: $0 [start|stop]"
exit 1
