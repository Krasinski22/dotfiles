#!/bin/bash

# Define direção: +1 ou -1
direction=$1

# Pega a workspace atual (número)
current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')

# Se falhar, sai
[ -z "$current" ] && exit 1

# Calcula próxima workspace
next=$((current + direction))

# Evita workspaces com número zero ou negativo
[ "$next" -le 0 ] && exit 1

# Vai para a nova workspace
i3-msg workspace number "$next"
