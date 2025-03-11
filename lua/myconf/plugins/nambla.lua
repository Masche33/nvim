return{
  {
    "jbyuki/nabla.nvim",
    config = function()
      
      vim.keymap.set("n", "<leader>rn", require("nabla").popup, {desc= "Render LAtex inline"})
    end;
  },
}
