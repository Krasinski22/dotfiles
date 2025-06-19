#!/bin/bash

direction=$1  # -1 ou 1

# Coleta workspaces com janelas, ordenadas
mapfile -t workspaces < <(i3-msg -t get_workspaces | jq '.[] | select(.visible or .focused or .urgent or .output != null) | .num' | sort -n)

# Workspace atual
current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused).num')

# Índice da atual
for i in "${!workspaces[@]}"; do
    if [ "${workspaces[$i]}" -eq "$current" ]; then
        index=$i
        break
    fi
done

# Wrap-around no índice
count=${#workspaces[@]}
next_index=$(( (index + direction + count) % count ))

# Muda de workspace
i3-msg workspace number "${workspaces[$next_index]}"
