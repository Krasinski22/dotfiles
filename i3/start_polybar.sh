#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config.ini
# Você pode especificar qual monitor a barra deve aparecer usando --screen=<nome_do_monitor>
# Ou você pode rodar várias instâncias do polybar, uma para cada monitor, se você tiver múltiplos
# polybar bar1 &
# polybar bar2 &

# Exemplo para monitor único:
polybar example &

echo "Polybar launched..."