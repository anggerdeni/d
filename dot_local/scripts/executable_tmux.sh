#!/bin/bash

SESSION_NAME="session1"
FIRST_WINDOW_NAME="fragment"
FIRST_WINDOW_COMMAND="sb"
NEW_WINDOW_NAME="project"
NEW_WINDOW_DIR="$HOME/work/project"

tmux new-session -d -s $SESSION_NAME
tmux send-keys -t ${SESSION_NAME}:0 "$FIRST_WINDOW_COMMAND" C-m
tmux rename-window -t ${SESSION_NAME}:0 $FIRST_WINDOW_NAME
tmux new-window -t $SESSION_NAME -n $NEW_WINDOW_NAME
tmux send-keys -t ${SESSION_NAME}:1 "cd $NEW_WINDOW_DIR" C-m
tmux attach -t $SESSION_NAME

