-- render-markdown.nvim.lua
return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
    'echasnovski/mini.icons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
  opts = {
        enable_auto_render = true,  
        enable_highlighting = true, 
    },
}

