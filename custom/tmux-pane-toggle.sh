# #!/bin/bashS
#
# # File to store pane info
# PANE_INFO_FILE="/tmp/tmux_pane_info"
# PANE_LOGS="/tmp/tmux_pane_logs"
#
# minimize_horizontal_pane() {
#     tmux resize-pane -t $1 -x 1
#     echo "$1 $2 $3 $3" > $PANE_INFO_FILE
# }
#
# # Minimize pane
# minimize_pane() {
#     tmux resize-pane -t $1 -x 1 -y 1
#     echo "$1 $2 $3 $4" > $PANE_INFO_FILE
#     echo "[minimizing-horizontal]: currentPane: $1 paneOrientation: $2 width: $3 height: $4" >> $PANE_LOGS
# }
#
# # Restore Pane
# restore_pane() {
#     if [ -f $PANE_INFO_FILE ]; then
#         while IFS= read -r line; do
#             pane_id=$(echo $line | awk '{print $1}')
#             if [ "$pane_id" == "$1" ]; then
#                 orientation=$( echo $line | awk '{print $2}' )
#                 width=$( echo $line | awk '{print $3}' )
#                 height=$( echo $line | awk '{print $4}' )
#                 if [ "$orientation" == "horizontal"]; then
#                     tmux resize-pane -t $1 -v $height
#                 else 
#                     tmux resize-pane -t $1 -x $width
#                 fi 
#                 sed -i "/$pane_info/d" $PANE_INFO_FILE
#             fi
#         done < $PANE_INFO_FILE
#     fi
# }
#
# # Main logic to toggle pane
# current_pane=$(tmux display-message -p '#P')
# pane_orientation=$(tmux display-message -p '#{pane_current_command}')
# pane_width=$(tmux display-message -p '#{pane_width}')
# pane_height=$(tmux display-message -p '#{pane_height}')
#
# if grep -q $current_pane $PANE_INFO_FILE; then
#     echo "[currentPane]: $currentPane -> restoring..." >> $PANE_LOGS
#     restore_pane $current_pane
# else 
#     echo "Minimizing..."
#     echo "[currentPane]: $currentPane -> minimizing..." >> $PANE_LOGS
#     minimize_pane $current_pane $pane_orientation $pane_width $pane_height
# fi
#!/bin/bash

# File to store pane info
PANE_INFO_FILE="/tmp/tmux_pane_info"

# Function to minimize pane
minimize_pane() {
  tmux resize-pane -t $1 -x 1 -y 1
  echo "$1 $2 $3 $4" > $PANE_INFO_FILE
}

# Function to restore pane
restore_pane() {
  if [ -f $PANE_INFO_FILE ]; then
    while IFS= read -r line; do
      pane_id=$(echo $line | awk '{print $1}')
      if [ "$pane_id" == "$1" ]; then
        orientation=$(echo $line | awk '{print $2}')
        width=$(echo $line | awk '{print $3}')
        height=$(echo $line | awk '{print $4}')
        if [ "$orientation" == "horizontal" ]; then
          tmux resize-pane -t $1 -y $height
        else
          tmux resize-pane -t $1 -x $width
        fi
        sed -i "/$pane_id/d" $PANE_INFO_FILE
      fi
    done < $PANE_INFO_FILE
  fi
}

# Main logic to toggle pane
current_pane=$(tmux display-message -p '#P')
pane_orientation=$(tmux display-message -p '#{pane_current_command}')
pane_width=$(tmux display-message -p '#{pane_width}')
pane_height=$(tmux display-message -p '#{pane_height}')

if grep -q $current_pane $PANE_INFO_FILE; then
  restore_pane $current_pane
else
  minimize_pane $current_pane $pane_orientation $pane_width $pane_height
fi

