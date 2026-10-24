return {
    "nvim-tree/nvim-tree.lua",

    config = function()
        local nvimtree = require("nvim-tree")
        local key      = vim.keymap
        
        nvimtree.setup(



            key.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {desc = "Toggles side file explorer"})
        )
    end
}
