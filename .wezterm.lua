local wezterm = require 'wezterm'

local config = {}

-- Definindo o shell padrão (altere para o seu shell preferido)
-- Exemplo para Zsh:
-- config.default_prog = { '/usr/bin/zsh' }
-- Se usar Bash:
-- config.default_prog = { '/usr/bin/bash' }
-- Se usar Fish (com modo login):
config.default_prog = { '/usr/bin/fish', '-l' }
-- Definindo o tom de azul petróleo suave e opacidade
config.window_background_opacity = 0.85
config.text_background_opacity = 0.8

-- Outras configurações
-- config.font = wezterm.font("Fira Code") -- Descomente para usar Fira Code
config.font_size = 20

config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.use_fancy_tab_bar = false
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }



return config
