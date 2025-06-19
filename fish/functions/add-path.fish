function add-path
    if test -d $argv[1]
        # Verifica se já está no PATH
        if not contains $argv[1] $PATH
            # Adiciona no PATH temporariamente
            set -gx PATH $PATH $argv[1]
            # Adiciona no config.fish para persistência
            echo "set -gx PATH \$PATH $argv[1]" >> ~/.config/fish/config.fish
            echo "Diretório $argv[1] adicionado ao PATH permanentemente."
        else
            echo "Diretório já está no PATH."
        end
    else
        echo "Diretório não existe."
    end
end
