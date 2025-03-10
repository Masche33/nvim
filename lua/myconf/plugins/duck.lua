return {
   "tamton-aquib/duck.nvim",
   config = function()
     vim.keymap.set("n", "<leader>ham", function()
         require("duck").hatch("ඞ")
      end, {})
      vim.keymap.set("n", "<leader>hc", function()
         require("duck").cook()
      end, {})
      vim.keymap.set("n", "<leader>ha", function()
         require("duck").cook_all()
      end, {})
   end,
}
