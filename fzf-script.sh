#### USAGE (Another point of view of how to use 'superflow')

##########
#### TMUX - BASH LINKAGE

## C-space (ie; Prefix key - for both terminal & tmux) + h/j/k/l = 
## Open 'high frequency' directories in tmux in 
## new respective sessions. If a session is already present, then the client 'attaches' to that session 
## (if pressed from bash shell) or 'switches' to that session (if pressed from tmux shell).

#### FZF - TMUX - BASH LINKAGE

## If from bash terminal : 

## C-f = 
## Fzf opens, and the directory selected will be opened inside a new tmux session if not already created. If already created,
## then the client attaches to that session.

## If from Tmux session : 

## C-f + s = 
## Fzf shows up, and the directory selected will be opened inside a new tmux session if not already created. If already created,
## then the client attaches to that session.
## C-f + f = 
## Fzf shows up, and the selected directory will be opened inside a new window of the current session.
##########

export FZF_DEFAULT_OPTS='--no-height --no-reverse'

function bind_command() {
    selected_dir=$(find -L $HOME -type d -name '.*' -prune -o \
        -name 'node_modules' -prune -o \
        -type d -print | fzf)
    if [[ -n $selected_dir ]]; then
        tmux new-session -d -s "${selected_dir##*/}" -c "${selected_dir}" 2>/dev/null
        tmux attach-session -t "${selected_dir##*/}"
    fi
}

function BIND_COMMAND_TMUX_S() {
    selected_dir=$(find -L $HOME -type d -name '.*' -prune -o \
        -name 'node_modules' -prune -o \
        -type d -print | fzf)

    if [[ -n $selected_dir ]]; then
        tmux new-session -d -s "${selected_dir##*/}" -c "${selected_dir}" 2>/dev/null
        tmux switch-client -t "${selected_dir##*/}"
    fi
    }
function BIND_COMMAND_TMUX_W() {
    selected_dir=$(find -L $HOME -type d -name '.*' -prune -o \
        -name 'node_modules' -prune -o \
        -type d -print | fzf)
    if [[ -n $selected_dir ]]; then
        tmux new-window -n "${selected_dir##*/}" -c "${selected_dir}"
    fi

}

if [[ -n "$TMUX" ]]; then
    bind -x '"\C-ff": BIND_COMMAND_TMUX_W'
    bind -x '"\C-fs": BIND_COMMAND_TMUX_S'
else
    bind -x '"\C-f": bind_command'
fi

export -f BIND_COMMAND_TMUX_S
export -f BIND_COMMAND_TMUX_W

