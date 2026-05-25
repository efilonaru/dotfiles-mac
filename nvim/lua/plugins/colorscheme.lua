return {
  -- Everforest theme (Lua port, better Neovim support)
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- load before everything else
    config = function()
      require("everforest").setup({
        -- "soft", "medium", or "hard" — controls background darkness
        background = "medium",
        -- how much to dim inactive windows
        dim_inactive_windows = false,
        -- italics in comments and keywords
        italics = true,
        -- transparent background (set true if you want Ghostty blur to show through)
        transparent_background_level = 0,
      })
    end,
  },

  -- Tell LazyVim to use everforest as the active colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
