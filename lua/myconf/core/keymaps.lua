local key = vim.keymap -- For cleaner code

-- for future use 
local ignored_filetypes = {
   "NvimTree",
}

-- for future use 
local ignored_buftypes = {
  "terminal"
}

-- Lazy
key.set("n", "<leader>l", ":Lazy<cr>", {desc="Apre Lazy"})

-- move lines
key.set("n", "<M-u>", ":m .+1<CR>==", { desc = "Move line down" })
key.set("n", "<M-i>", ":m .-2<CR>==", { desc = "Move line up" })
key.set("v", "<C-M-u>", ":m '>+1<CR>gv=gv", { desc = "Move slection down" })
key.set("v", "<C-M-i>", ":m '<-2<CR>gv=gv", { desc = "Move slection up" })


-- Select all
key.set("n", "<C-a>", "ggVG$", { desc = "Select all the file"})
key.set("i", "<C-a>", "<ESC>ggVG$", { desc = "Select all the file"})

-- Closes the window  
key.set("n", "<C-c>", ":q<CR>", {desc ="Closes the window"})
key.set("n", "<leader>q", ":q!<CR>", {desc ="Forces the closing of the window"})
key.set("n", "<leader>wq", ":wq<CR>", {desc ="Saves and closes"})

-- Copy into clipboard
key.set({ "n", "v" }, "Y", '"+y', { desc = "Copies into clipboard the select text" })

-- Terminal
key.set("n", "<C-t>", ":term<CR>", {desc = "Opens a terminal"})
key.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit from terminal mode" })

-- disable arrow keys and mouse
key.set("n", "<ScrollWheelUp>", "")
key.set("n", "<S-ScrollWheelUp>", "")
key.set("n", "<C-ScrollWheelUp>", "")
key.set("n", "<ScrollWheelDown>", "")
key.set("n", "<S-ScrollWheelDown>", "")
key.set("n", "<C-ScrollWheelDown>", "")
key.set("n", "<ScrollWheelLeft>", "")
key.set("n", "<S-ScrollWheelLeft>", "")
key.set("n", "<C-ScrollWheelLeft>", "")
key.set("n", "<ScrollWheelRight>", "")
key.set("n", "<S-ScrollWheelRight>", "")
key.set("n", "<C-ScrollWheelRight>", "")
vim.opt.mouse = ""
key.set("n", "<Up>", "")
key.set("n", "<Down>", "")
key.set("n", "<Left>", "")
key.set("n", "<Right>", "")
key.set("v", "<Up>", "")
key.set("v", "<Down>", "")
key.set("v", "<Left>", "")
key.set("v", "<Right>", "")
key.set("i", "<Up>", "")
key.set("i", "<Down>", "")
key.set("i", "<Left>", "")
key.set("i", "<Right>", "")

-- Open new file
key.set("n", "<leader>n", ":enew<CR>", {desc = "Opens a void file"})
key.set("v", "<leader>n", ":enew<CR>", {desc = "Opens a void file"})

-- Function to handle split navigation and creation
local function navigate_or_create_split(direction)
   local current_win = vim.api.nvim_get_current_win()
   local current_buf = vim.api.nvim_get_current_buf()
   local filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
   local buftype = vim.api.nvim_buf_get_option(current_buf, "buftype")

   -- Check if the current buffer's filetype or buftype is in the ignored list
   local is_ignored = vim.tbl_contains(ignored_filetypes, filetype) or vim.tbl_contains(ignored_buftypes, buftype)

   vim.cmd("wincmd " .. direction)
   if vim.api.nvim_get_current_win() == current_win and not is_ignored then

      local win_count = #vim.api.nvim_list_wins()
      if win_count < vim.g.max_windows then
         if direction == "h" then
            vim.cmd("leftabove vsplit")
         elseif direction == "j" then
            vim.cmd("belowright split")
         elseif direction == "k" then
            vim.cmd("aboveleft split")
         elseif direction == "l" then
            vim.cmd("rightbelow vsplit")
         end
         vim.cmd("wincmd " .. direction)
      else
         vim.api.nvim_echo({  { "Maximum number of splits (" .. vim.g.max_windows .. ") reached", "WarningMsg" } }, false, {})
         vim.defer_fn(function()
            vim.cmd("echo ''")
         end, 1000)
      end
   end
end

-- Key mappings for split navigation and creation
key.set("n", "<C-h>", function()
   navigate_or_create_split("h")
end, { noremap = true, silent = true, desc = "Move to left split or create one" })
key.set("n", "<C-j>", function()
   navigate_or_create_split("j")
end, { noremap = true, silent = true, desc = "Move to down split or create one" })
key.set("n", "<C-k>", function()
   navigate_or_create_split("k")
end, { noremap = true, silent = true, desc = "Move to up split or create one" })
key.set("n", "<C-l>", function()
   navigate_or_create_split("l")
end, { noremap = true, silent = true, desc = "Move to right split or create one" })
key.set("n", "<C-c>", "<C-w>c")


