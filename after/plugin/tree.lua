-- empty setup using defaults
require("nvim-tree").setup({
    view = {
        side = "right"
    },
    -- disable rendering icons
    renderer = {
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = true
            }
        }
    }
})
