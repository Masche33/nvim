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

## Remapping guide:

The new key association:

- Ctrl+a: Select all
- Ctrl+c: Closes the current windows
- ' q': Forces the closing of a page
- ' wq': Saves and exits
- Y: Copies into clipboard
- Ctrl+t: Open a terminal in the current window
- Ctrl+h,j,k,l: Moves between the windows, and if the movement goes trough a wall it creates a new window if the maximum was not already reached.
- 

## Options:

The custom settings are:

- 2 space tab
- Relative number
- number(The number are setted to be at 4 digit)

## Globals:

Is used to store global variable in a single position and avoid dispersion.

## Plugins:

In this configuration for the moment there are not plugin
