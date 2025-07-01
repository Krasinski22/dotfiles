function trash --description 'Move files/folders to the trash'
    if test -z "$argv"
        echo "Uso: trash <arquivo/pasta>..."
        return 1
    end

    # Tenta usar gio trash primeiro (mais comum em ambientes gráficos GNOME/GTK)
    if type -q gio
        gio trash $argv
        return $status
    end

    # Se gio não estiver disponível, tenta usar o comando trash do trash-cli
    if type -q trash
        trash $argv
        return $status
    end

    # Se nenhuma das opções acima for encontrada, informa ao usuário
    echo "Erro: Nem 'gio' nem 'trash' foram encontrados."
    echo "Por favor, instale 'trash-cli' (sudo apt install trash-cli) ou verifique sua instalação do 'gio'."
    return 1
end

