# NVIM

My nvim config.

## Dependencies:

To install all the dependences run the 'dependencies.sh' script, here follows the list of all the depencencies:

The list at the moment is empty.

## New commands:

### Path:

Shows the absolute path of the current file.

### Cpath:

Copies the absolute path of the current file.

### SM:

Passing a number it sets the new maximum windows in nvim. If left blank it sets it to default (vim.g.max_windows). 

### RF: 

Reloads the confinguration.

## Remapping guide:

The new key association:

- Ctrl+a: Select all
- Ctrl+c: Closes the current windows
- Y: Copies into clipboard
- Ctrl+t: Open a terminal in the current window
- Ctrl+h,j,k,l: Moves between the windows, and if the movement goes trough a wall it creates a new window if the maximum was not already reached.
- Alt+u,i: Moves down/up a line in normal mode
- Ctrl+Alt+u,i: Moves down/up a line in visual mode

- ' n': Closes the file but not the window
- ' wq': Saves and exits
- ' q': Forces the closing of a page



## Options:

The custom settings are:

- 2 space tab
- Relative number
- number(The number are setted to be at 4 digit)

## Globals:

Is used to store global variable in a single position and avoid dispersion.

## Plugins:

- Lazy.nvim: to manage packages
- TreeSitter: Dependecies of lazy.nvim
- nvim tree: To have and resource explorer in nvim
