# Superflow
Navigate to any directory from anywhere and Tmuxify every directory you navigate to.

## Why ?
Whenever I open my system, I need to open a tmux session for any one of my highly frequent project directories (1 to 4 of them) from the bash shell using one button press. And whenever I need to go to a random project directory, I needed that project directory to be opened up in a tmux session as fast as possible. This was one trigger.

2nd. Whenever I am inside Nvim (in a project directory) in a tmux session, if i needed to jump to another directory in a new tmux window, I had to create a new window, then cd into the project directory. I wanted this in just one button press from inside Nvim.

thus.. `superflow` :))

## What is Superflow ? 

An fzf-shell-tmux-nvim integration for programmers who need 'superflow' (read: 'instant') navigations between directories & for tmuxifying every directory you navigate to.

_Opinionated for one specific context: `superflow` doesn't allow you to jump to a tmuxified directory from an nvim editor if the nvim was not opened inside a tmux environment
(ie; you can't jump by pressing 'C-f' if you're inside nvim but not in a tmux session). Because, you shouldn't open nvim outside a tmux environment._ 

_2 reasons :_

_1. If it is allowed to jump to a tmux session from nvim (which is not opened in a tmux session) by pressing 'C-f', then the unsaved file edits (buffer) in nvim will not be transferred to tmux. Thus causing you to lose the edits you made._

_2. This would deprive you of tmux advantages._


## How does this 'flow' (Read: 'work')?

**1. While either outside or inside tmux :**

To goto high frequent project directories (Ranked according to priority):- 

    (Ctrl-Space = Prefix key for both Bash and Tmux)
```
    Ctrl-Space + h = Open high frequent (rank 1)  project directory in tmux session
    Ctrl-Space + j = Open high frequent (rank 2)  project directory in tmux session
    Ctrl-Space + k = Open high frequent (rank 3)  project directory in tmux session
    Ctrl-Space + l = Open high frequent (rank 4)  project directory in tmux session
```
**2. While outside tmux (ie; You have just started the system, and you are in a shell not spawned by tmux) :**
    
To goto a random project directory :-
```
    Ctrl-f = Shows up fzf (fuzzy finder); search the project directory - opens the directory in a tmux session
```
**3. While inside nvim in tmux Or inside a tmux session/tmux environment** (Well, you shouldn't open nvim outside a tmux environment if you are a developer (& you won't need to.. if you are using 'superflow':)) ) **:** 
    
To goto a random project directory :-
```
    Ctrl-f + s = Shows up fzf (fuzzy finder); search the project directory - opens up the directory in a tmux session
    Ctrl-f + f = Shows up fzf (fuzzy finder); search the project directory - opens up the directory in a tmux window in the same session
```
## SETUP / INSTALLATION

> TIP : _If you are using Qwerty keyboard, remap CTRL functionality to 'CAPSLOCK' key for better hand comfort & speed. You don't need CAPSLOCK.. well... do you ?_

### 0. Required dependencies
- [tmux](https://github.com/tmux/tmux/wiki) (terminal multiplexer)
- [fzf](https://github.com/junegunn/fzf) (command line fuzzy finder)
    
#### 1. Create ~/.scripts directory
#### 2. Copy tmux-script.sh, fzf-script.sh to ~/.scripts directory
#### 2.1 For Nvim users: Copy nvimfzf-script.sh also to ~/.scripts directory
    
#### 3. Put the below instructions into `~/.config/nvim/after/plugin/keymaps.lua` file (Create the directories & file if not already exists)
```.lua
    if vim.env.TMUX ~= nil and vim.env.TMUX ~= "" then
        vim.keymap.set("n", "<C-f>f", "<cmd>silent !tmux neww ~/.scripts/nvimfzf-script.sh 'w'<CR>")
        vim.keymap.set("n", "<C-f>s", "<cmd>silent !tmux neww ~/.scripts/nvimfzf-script.sh 's'<CR>")
    end
```

#### 4. Put these instructions in ~/.tmux.conf :
```.tmux
set-option -g prefix 'C-@'
# High frequency directories
bind-key h run-shell "bash ~/.scripts/tmux-script.sh 'h'"
bind-key j run-shell "bash ~/.scripts/tmux-script.sh 'j'"
bind-key k run-shell "bash ~/.scripts/tmux-script.sh 'k'"
bind-key l run-shell "bash ~/.scripts/tmux-script.sh 'l'"
```
#### 5. Put these instructions in ~/.bashrc (for bash users)
```.bash
# scripts
source ~/.scripts/tmux-script.sh
source ~/.scripts/fzf-script.sh
```
#### 5. Specify the High frequency directories, & custom session names for each directory by following the instruction below
###### 5.1 Open tmux-script.sh & specify your high frequency directory locations :

```.bash
    #HIGH FREQUENCY DIRECTORIES : CHANGE THESE
    If your high frequency directories are inside HOME directory : 
    HIGH_FREQ_DIR0="$HOME/edit-path-to-high-freq-directory0"
    HIGH_FREQ_DIR1="$HOME/edit-path-to-high-freq-directory1"
    HIGH_FREQ_DIR2="$HOME/edit-path-to-high-freq-directory2"
    HIGH_FREQ_DIR3="$HOME/edit-path-to-high-freq-directory3"

    HIGH_FREQ_DIR0_NAME="edit_here"
    HIGH_FREQ_DIR1_NAME="edit_here"
    HIGH_FREQ_DIR2_NAME="edit_here"
    HIGH_FREQ_DIR3_NAME="edit_here"
```
_Eg:<br>_
_HIGH_FREQ_DIR0="$HOME/edit-path-to-high-freq-directory0" <br>_  _is changed to <br>_  _HIGH_FREQ_DIR0="$HOME/projects/draw-code"_
<br><br>
#### That's it ! Enjoy `Superflow`!!

## Contributing
All contributions are welcome! Just open a pull request.
