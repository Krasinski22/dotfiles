function remove-path
    if test -z "$argv[1]"
        echo "Use: remove-path [diretório]"
        return 1
    end

    set dir $argv[1]

    # Remove do PATH atual
    set PATH (string match -v -- $dir -- $PATH)

    # Remove linha no config.fish, usando | como delimitador no sed para evitar conflito com /
    if test -f ~/.config/fish/config.fish
        sed -i "\|set -gx PATH.*$dir|d" ~/.config/fish/config.fish
    end

    echo "Diretório $dir removido do PATH."
end
