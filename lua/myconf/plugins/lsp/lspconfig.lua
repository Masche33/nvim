return {
   "neovim/nvim-lspconfig",
   event = { "BufReadPre", "BufNewFile" },
   dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
   },

   config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local util = require("lspconfig.util")
      local key = vim.keymap

      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("UserLspConfig", {}),
         callback = function(ev)
            local opts = { buffer = ev.buf, silent = true } -- buffer local mappings

            opts.desc = "show LSP references"
            key.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            opts.desc = "go to declaration"
            key.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "show LSP definitions"
            key.set("n", "gT", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "show LSP implementations"
            key.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "show LSP type definitions"
            key.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "see available code actions"
            key.set({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "smart rename"
            key.set("n", "<leader>lr", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "show buffer diagnostics"
            key.set("n", "<leader>lb", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "show line diagnostics"
            key.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "go to previous diagnostic"
            key.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "go to next diagnostic"
            key.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "show documentation for what is under cursor"
            key.set("n", "<leader>lcd", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "restart LSP"
            key.set("n", "<leader>lrs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
         end,
      })

      local capabilities = cmp_nvim_lsp.default_capabilities() -- used to enable autocompletion (assign to every lsp server config)
      -- diag symbols in the gutter   
      -- NB some icons does not change here
      local signs = { Error = "✖ ", Warn = "󱈸", Hint = "󱐋", Info = "" }
      for type, icon in pairs(signs) do
         local hl = "DiagnosticSign" .. type
         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      mason_lspconfig.setup_handlers({ -- default handler for installed servers
         function(server_name)
            lspconfig[server_name].setup({
               capabilities = capabilities,
            })
         end,
         ["svelte"] = function() -- configure svelte server
            lspconfig["svelte"].setup({
               capabilities = capabilities,
               on_attach = function(client, bufnr)
                  vim.api.nvim_create_autocmd("BufWritePost", {
                     pattern = { "*.js", "*.ts" },
                     callback = function(ctx)
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) -- Here use ctx.match instead of ctx.file
                     end,
                  })
               end,
            })
         end,
         ["graphql"] = function() -- configure graphql language server
            lspconfig["graphql"].setup({
               capabilities = capabilities,
               filetypes = {
                  "graphql",
                  "gql",
                  "svelte",
                  "typescriptreact",
                  "javascriptreact",
               },
            })
         end,
         ["emmet_ls"] = function() -- configure emmet language server
            lspconfig["emmet_ls"].setup({
               capabilities = capabilities,
               filetypes = {
                  "html",
                  "typescriptreact",
                  "javascriptreact",
                  "css",
                  "sass",
                  "scss",
                  "less",
                  "svelte",
               },
            })
         end,
         ["gopls"] = function() -- configure gopls
            lspconfig["gopls"].setup({
               capabilities = capabilities,
               cmd = { "gopls" },
               filetypes = {
                  "go",
                  "gomod",
                  "gowork",
                  "gotmpl",
               },
               root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            })
         end,
         ["clangd"] = function()
            lspconfig["clangd"].setup({
               capabilities = capabilities,
               filetypes = {
                  "c",
                  "cpp",
                  "c++",
               },
               settings = {
                  clangd = {
                     format = {
                        enable = true,
                        style = "file",
                     },
                  },
               },
            })
         end,
         ["lua_ls"] = function()
            lspconfig["lua_ls"].setup({ -- configure lua server (with special settings)
               capabilities = capabilities,
               settings = {
                  Lua = {
                     diagnostics = { -- make the language server recognize "vim" global
                        globals = { "vim" },
                     },
                     completion = {
                        callSnippet = "Replace",
                     },
                  },
               },
            })
         end,
         ["jdtls"] = function()
            lspconfig["jdtls"].setup({
               capabilities = capabilities,
               file_types = {
                  "java",
               },
               root_dir = util.root_pattern(".git", "build.gradle", "settings.gradle"),
               -- settings = {},
            })
         end,
      })

      -- diagnostics managing
      vim.diagnostic.config({
         virtual_text = true, -- keep inline diagnostics
         signs = true, -- keep signs in the gutter
         underline = false, -- keep underlines
         update_in_insert = false, -- don't show diagnostics in insert mode
      })

      local diagnostics_active = true -- toggle diagnostics
      function _G.toggle_diagnostics()
         diagnostics_active = not diagnostics_active
         if diagnostics_active then
            vim.diagnostic.show()
         else
            vim.diagnostic.hide()
         end
      end

      vim.api.nvim_set_keymap(
         "n",
         "<leader>td",
         ":lua toggle_diagnostics()<CR>",
         { desc = "toggle diagnostics", noremap = true, silent = true }
      )
   end,
}
