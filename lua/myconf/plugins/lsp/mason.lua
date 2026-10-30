return {
   "williamboman/mason.nvim",
   dependencies = {
      "williamboman/mason-lspconfig.nvim",
   },
   config = function()
      require("mason").setup({
         ui = {
            icons = {
               package_installed = "",
               package_pending = "",
               package_uninstalled = "",
            },
         },
      })

      require("mason-lspconfig").setup({
         automatic_enable = true,
         ensure_installed = {
            "rust_analyzer",
            "stylua",
         },
      })

   end,
}
