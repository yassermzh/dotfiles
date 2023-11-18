-- empty setup using defaults
require("nvim-tree").setup({
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
