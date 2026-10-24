local key = vim.keymap


-- Open the terminal
key.set("n", "<C-t>", ":term<CR>", {desc = "Opens a terminal"})

-- Copy into clipboard
key.set({ "n", "v" }, "Y", '"+y', { desc = "Copies into clipboard the select text" })


--Closing windows
key.set("n", "<C-c>", ":q<CR>", {desc="Closes the windows"})

-- Lazyvim
key.set("n", "<leader>l", ":Lazy<CR>", {desc="It opens Lazy"})

-- Navitagion between splits

local split_map = {
    h = {name = "left ", cmd = "leftabove  vsplit"},
    l = {name = "right", cmd = "rightbelow vsplit"},
    j = {name = "down", cmd = "belowright split"},
    k = {name = "up", cmd = "aboveleft  split"},
}

local ignored_filetypes = {
   "NvimTree",
}

local ignored_buftypes = {
}

local function move_or_split(direction)
    vim.api.nvim_echo({{"Function called"}}, false, {})
    local curr_win = vim.api.nvim_get_current_win()
    local curr_buf = vim.api.nvim_get_current_buf()

    local filetype = vim.bo[curr_buf].filetype
    local buftype  = vim.bo[curr_buf].buftype

    local is_ignored = vim.tbl_contains(ignored_filetypes, filetype) or
                       vim.tbl_contains(ignored_buftypes, buftype)

    vim.cmd("wincmd " .. direction)
    
    -- If its still in the same split create one
    if vim.api.nvim_get_current_win() == curr_win and not is_ignored then
        local win_count = #vim.api.nvim_list_wins() 
        if win_count < (vim.g.max_win or 4) then
            vim.cmd(split_map[direction].cmd) 
            vim.cmd("wincmd " .. direction)
        end
    end
end

for d, s in pairs(split_map) do
    key.set("n", "<C-"..d..">", function()
        move_or_split(d)
    end, {silent = true, desc = "Move or split to the " .. s.name})
end
