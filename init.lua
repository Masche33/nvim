require("myconf.core")
require("lazy").setup({
  spec = {
    { import = "myconf.plugins.spec1" },  
  },
  checker = { enabled = true },  -- Controllo automatico per gli aggiornamenti dei plugin
})
