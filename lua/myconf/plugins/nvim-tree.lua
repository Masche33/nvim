return {
   "nvim-tree/nvim-tree.lua",
   -- dependencies = "nvim-tree/nvim-web-devicons",
   config = function()
      local nvimtree = require("nvim-tree")
      local key = vim.keymap

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local function custom_on_attach(bufnr)
         local api = require("nvim-tree.api")
         local function opts(desc)
            return {
               desc = "nvim-tree: " .. desc,
               buffer = bufnr,
               noremap = true,
               silent = true,
               nowait = true,
            }
         end
         api.config.mappings.default_on_attach(bufnr)

         local function reveal_in_finder()
            local node = api.tree.get_node_under_cursor()
            if node and node.absolute_path then
               os.execute("open -R " .. vim.fn.shellescape(node.absolute_path))
            end
         end

         key.del("n", "<C-]>", { buffer = bufnr })
         key.del("n", "s", { buffer = bufnr })
         key.set("n", "<S-CR>", api.tree.change_root_to_node, opts("CD"))
         key.set("n", "<S-BS>", api.tree.change_root_to_parent, opts("Up"))
         key.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
         key.set("n", "l", api.node.open.edit, opts("Open"))
         key.set("n", "o", api.node.run.system, opts("Open with default app"))
         key.set("n", "O", reveal_in_finder, opts("Reveal in Finder"))
      end

      nvimtree.setup({
         on_attach = custom_on_attach,

         view = {
            width = 35,
            relativenumber = false,
            number = false,
         },

         update_cwd = true, -- update nvim-tree root to cwd
         update_focused_file = { -- update the focused file on `nvim-tree`
            enable = true,
         },

         renderer = {
            add_trailing = true,
            indent_width = 2,
            full_name = true,
            root_folder_label = function(path)
               return vim.fn.fnamemodify(path, ":t")
            end,
            indent_markers = {
               enable = true,
               icons = {
                  item = "├",
               },
            },
            icons = {
               show = {
                  file = false,
                  folder = false,
                  git = true,
                  hidden = false,
               },

               git_placement = "after",
               glyphs = {
                  folder = {
                     arrow_closed = "\u{2013}", -- closed folder
                     arrow_open = "\u{00B7}", -- opened folder
                     default = "", -- icon for closed folders
                     open = "", -- icon for opened folders
                  },
                  git = {
                     unstaged = "✗",
                     staged = "✓",
                     unmerged = "",
                     renamed = "➜",
                     untracked = "?",
                     deleted = "-",
                     ignored = "◌",
                  },
               },
            },
         },

         -- disable window_picker for explorer to work well with window splits
         actions = {
            open_file = {
               window_picker = {
                  enable = false,
               },
            },
         },
         filters = {
            custom = { ".DS_Store", "node_modules/", ".git/" },
         },
         git = {
            ignore = false,
         },
      })

      -- set keymaps
      key.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
      key.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" }) -- toggle file explorer on current file
      -- key.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
      key.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
      key.set("n", "<leader>et", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in file explorer" })
   end,
}
