sudo apt install tmux

git clone https://github.com/YanivZalach/Tmux_Config.git ~/.Tmux_Config
mv ~/.Tmux_Config/.tmux.conf ~/.
vi .tmux.conf


# _________  _____ ______   ___  ___     ___    ___ 
#|\___   ___\\   _ \  _   \|\  \|\  \   |\  \  /  /|
#\|___ \  \_\ \  \\\__\ \  \ \  \\\  \  \ \  \/  / /
#     \ \  \ \ \  \\|__| \  \ \  \\\  \  \ \    / / 
#      \ \  \ \ \  \    \ \  \ \  \\\  \  /     \/  
#       \ \__\ \ \__\    \ \__\ \_______\/  /\   \  
#        \|__|  \|__|     \|__|\|_______/__/ /\ __\ 
#                                       |__|/ \|__| 
#
#------------------PREFIX------------------

# Use C-a as the prefix key, which is on the home row and easier to reach than C-b.
set -g prefix C-a
set -g prefix2 C-x
bind C-a send-prefix
 
#------------------SETTINGS------------------
 
# Use Vi-like keybindings
set-window-option -g mode-keys vi

# Enable mouse support
set-option -g mouse on

# Allow immediate use of arrow keys after changing windows
set-option -g repeat-time 0

# Automatically renumber windows to fill gaps
set-option -g renumber-windows on

# Set the default terminal to support 256 colors
set-option -g default-terminal tmux-256color

# Set window options and layout preferences
set-window-option -g other-pane-height 70
set-window-option -g other-pane-width 80
set-window-option -g display-panes-time 1500

# Set window notifications
set-window-option -g monitor-activity on
set-option -g visual-activity on


# Disable assume-paste-time for compatibility with iTerm6's "Send Hex Codes" feature
set-option -g assume-paste-time 0


#------------------STATUS_LINE------------------

# Move the status bar to the top of the terminal window
set-option -g status-position bottom


# Other status bar settings
set-option -g status-interval 1

# Info displayed
set-option -g status-left '[#S] '
set-option -g status-right '#{?selection_present,#[reverse]<Copy Mode>#[noreverse] ,} #{?pane_synchronized,#[reverse]<Pane Sync>#[noreverse] ,} #{?client_prefix,#[reverse]<Prefix>#[noreverse] ,} #{=21:pane_title} %H:%M %d-%b-%y'
set-option -g status-fg default


#------------------COLORS------------------

# Pane and border colors
set-option -g pane-active-border-style bg=black
set-option -g status-style bg=cyan,fg=black

# Set the separator style for panes
set-option -g pane-border-style fg=cyan
set-option -g pane-active-border-style fg=blue

set-window-option -g window-status-current-style fg=yellow,bold,bg=black


#------------------KEY_BINDINGS------------------

# Configuration reload
bind-key r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."


# Quitting TMUX
bind-key X confirm-before -p "Kill this windows? (y/n)" "kill-window"
bind-key Q confirm-before -p "Kill session #S? (y/n)" kill-session
bind-key q confirm-before -p "Kill this pane? (y/n)" "kill-pane"


# Use Ctrl-a followed by s to detach (equivalent to Ctrl-b d)
bind s detach-client


# Command Prompt
bind-key : command-prompt

# clearing the terminal window
bind C-l send-keys 'C-l'


#---Session---
# Switch sessions with a convenient keybinding
bind-key C-s choose-tree

# Rename the name of a session
bind-key M command-prompt -p "Rename session:" "rename-session '%%'"



# ---WINDOWS---
# Creating a new window
bind-key c new-window

# Moving throw the windows-Tab
bind-key t next-window
bind-key T previous-window
bind-key C-o rotate-window

# Moving throw the windows using the Shift+Arrow Key
bind -n S-Left previous-window
bind -n S-Right next-window

# Reordering the windows using Ctrl+Shift+Arrow Key
bind-key -n C-S-Left swap-window -t -1
bind-key -n C-S-Right swap-window -t +1


# Rename the name of a window
bind-key m command-prompt -p "Rename window:" "rename-window '%%'"



# ---PANES---

# Enable smart pane switching with Vim\Nvim awareness
# If not in Vim/Nvim: Ctrl + h/j/k/l -> movment between payes AND Alt + Arrow Keys resize panes
# Vim
#	Moving
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-l) || tmux select-pane -R"
bind -n C-\\ run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys 'C-\\') || tmux select-pane -l"
#Nvim
#	Moving
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-l) || tmux select-pane -R"
bind -n C-\\ run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys 'C-\\') || tmux select-pane -l"
#	Resizing
bind -n M-Left run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys M-Left) || tmux resize-pane -L 5"
bind -n M-Down run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys M-Down) || tmux resize-pane -D  5"
bind -n M-Up run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys M-Up) || tmux resize-pane -U 5"
bind -n M-Right run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys M-Right) || tmux resize-pane -R 5"

# Moving throw panes in a Vim/Nvim window
bind-key Left select-pane -L
bind-key Down select-pane -D
bind-key Up select-pane -U
bind-key Right select-pane -R

# Resizing the panes with Arrow Key
bind-key h resize-pane -L 7
bind-key j resize-pane -D 7
bind-key k resize-pane -U 7
bind-key l resize-pane -R 7

# Use My-Vim-like keys for splitting and managing panes
bind-key x split-window -h -c "#{pane_current_path}"
bind-key y split-window -v -c "#{pane_current_path}"

# Synchronize panes
bind S set-window-option synchronize-pane\; display-message "synchronize mode toggled."

# Panes layout
bind-key C-y select-layout main-horizontal
bind-key C-x select-layout main-vertical
bind-key enter next-layout

# Pane circling
bind-key e last-pane
bind-key d display-panes

# Custom keybindings for various actions
bind-key R refresh-client
bind-key Y clear-history


# ---Copy Mode---
# Enter copy mode
bind-key [ copy-mode

# Past from clipboard
bind-key ] paste-buffer

# In copy mode Vim-like bindings 
bind-key -Tcopy-mode-vi 'v' send -X begin-selection
bind-key -Tcopy-mode-vi 'y' send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"

# Fix to allow mouse wheel/trackpad scrolling in tmux 2.1
#bind-key -T root WheelUpPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
#bind-key -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"



