return {
  {
    "davidmh/cspell.nvim",
    dependencies = {
      {
        "Joakker/lua-json5",
        build = "./install.sh && mv lua/json5.dylib lua/json5.so",
        lazy = false,
        priority = 1000,
      },
    },
  }
}
