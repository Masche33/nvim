return {
   "neovim/nvim-lspconfig",
   dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
   },

   event = { "BufReadPost", "BufNewFile" },

   config = function()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
         callback = function(ev)
            local opts = { buffer = ev.buf, silent = true }

            opts.desc = "Show documentation for what is under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            opts.desc = "Smart rename"
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
            opts.desc = "See available code actions"
            vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
            opts.desc = "Go to previous diagnostic"
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            opts.desc = "Go to next diagnostic"
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            opts.desc = "Show line diagnostic"
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
         end,
      })

      local diagnostic_signs = {
         [vim.diagnostic.severity.ERROR] = "✖",
         [vim.diagnostic.severity.WARN] = "󱈸",
         [vim.diagnostic.severity.HINT] = "󱐋",
         [vim.diagnostic.severity.INFO] = "",
      }


      vim.lsp.config("rust_analyzer", {
         capabilities = capabilities,
         root_markers = { "Cargo.toml", "rust-project.json", ".git" },
         settings = {
            ["rust-analyzer"] = {
               check = {
                   command = "clippy",
               },
               cargo = { allFeatures = true },
               procMacro = { enable = true },
               completions = {
                  addUseImports = true,
                  postfix = { enable = true },
               },
               diagnostics = {
                   disabled = {"unlinked-file"},
               },
            },
         },
      })


      vim.diagnostic.config({
         virtual_text = true,
         signs = { text = diagnostic_signs },
         underline = false,
         update_in_insert = false,
      })

      vim.keymap.set("n", "<leader>td", function()
         local bufnr = vim.api.nvim_get_current_buf()
         local enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })
         vim.diagnostic.enable(not enabled, { bufnr = bufnr })
      end, { desc = "toggle diagnostics", noremap = true, silent = true })
   end,
}
