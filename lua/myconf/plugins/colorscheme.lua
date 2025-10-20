return {
   "folke/tokyonight.nvim",
   priority = 1000,

   config = function()
      local transparent = false -- set to true if you would like to enable transparency
      local black1 = "#000000"   -- "#10100F" -- "#10100D"
      local bg_high = "#1D1D19"
      local white = "#EFECDB"
      local grey1 = "#8D8C78"
      local comment = "#996645"
      --local comment = "#89594E"
      local green = "#88BF39" -- "#6DBF26"
      local orange1 = "#BF7F26"
      local blue1 = "#124EED"
      local dark1 = "#6D601B"
      local test1 = "#00A0FF"
      local test2 = "#9900FF"

      require("tokyonight").setup({
         style = "night",
         transparent = transparent,
         styles = {
            sidebars = "dark",
            floats = "dark",
         },
         on_colors = function(colors)
            colors.bg = black1
            colors.bg_dark = black1
            colors.bg_float = black1
            colors.bg_highlight = bg_high
            colors.bg_popup = black1
            colors.bg_search = blue1
            colors.bg_sidebar = black1
            colors.bg_statusline = black1
            colors.bg_visual = grey1
            colors.border = grey1
            colors.fg = white
            colors.fg_dark = white
            colors.fg_float = white
            colors.fg_gutter = grey1
            colors.fg_sidebar = white

            colors.comment = comment
            colors.blue1 = grey1 --types
            colors.magenta = grey1 -- keywords golang builtin like append, len etc.
            colors.cyan = grey1 -- go keywoards, c directives
            colors.blue5 = white -- punct
            colors.purple = grey1 -- c return keyword
            colors.yellow = white -- var names in function arguments
            colors.blue = white -- c func name

            colors.orange = green
            colors.green = green
            colors.green1 = white
            colors.magenta2 = orange1

            colors.blue2 = test2
            colors.blue6 = test1
            colors.blue7 = grey1
            colors.red = orange1
            colors.red1 = orange1
            colors.dark3 = dark1
            colors.dark5 = dark1

            colors.blue0 = test1
            --colors.orange = dark1 -- digits
            --colors.green2 = dark1
            --colors.teal = dark1
         end,
      })

      vim.cmd("colorscheme tokyonight")
   end,
}
