# tmux configuration for this project
source-file ~/.tmux.conf
new-session -s get_token -n editor -d
send-keys -t get_token 'cd ~/workspace/get_token' C-m
split-window -h -t get_token
resize-pane -t get_token:1.1
send-keys -t get_token:1.2 'cd ~/workspace/get_token' C-m
select-pane -t get_token:1.1
new-window -n console -t get_token
send-keys -t get_token:2 'cd ~/workspace/get_token && rerun "ruby app.rb"' C-m
select-window -t get_token:1
