local wezterm = require 'wezterm'

return {
  -- Definindo o tom de azul petróleo suave
  window_background_opacity = 0.7,  -- Transparência do fundo do terminal
  text_background_opacity = 0.8,    -- Opacidade do fundo do texto (ajuste conforme necessário)
  window_background_opacity = 0.85,
  

  -- Outras configurações
  -- font = wezterm.font("Fira Code"),
  font_size = 11.5,

  color_scheme = "Catppuccin Mocha",  -- Ou escolha um esquema que combine com o tom de azul

  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  use_fancy_tab_bar = false,
  window_padding = { left = 10, right = 10, top = 10, bottom = 10 },
}
