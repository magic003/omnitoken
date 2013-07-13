# tmux configuration for this project
source-file ~/.tmux.conf
new-session -s omnitoken -n editor -d
send-keys -t omnitoken 'cd ~/workspace/omnitoken' C-m
split-window -h -t omnitoken
resize-pane -t omnitoken:1.1
send-keys -t omnitoken:1.2 'cd ~/workspace/omnitoken' C-m
select-pane -t omnitoken:1.1
new-window -n console -t omnitoken
send-keys -t omnitoken:2 'cd ~/workspace/omnitoken && rerun "ruby omnitoken_app.rb"' C-m
select-window -t omnitoken:1
