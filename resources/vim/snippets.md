Vim 4L (Vim For Life)
======

# Set a specific syntax
`:set syntax typescript`

# Sort alphabetically
`:21,28sort u`

# Search for newline character and replace
```
http://stackoverflow.com/questions/24506714/replacing-new-line-characters-with-literal-n-in-macvim

:%s/\n/, 
```

# Open existing tab in a new tab - copy over
```
Split up the screen (Ctrl-W s), take up a window, and Ctrl-W T

//has to be a better way than this?
ref: http://superuser.com/questions/66179/how-do-i-edit-an-existing-buffer-in-a-new-tab-in-vim
```

# Grep
```
:grep -r "search-for" ../path
```

# Put Vim in paste mode
```
:set paste
```

# Reload Editorconfig
```
:EditorConfigReload
```

# Fix syntax highligting
`syntax sync fromstart`

# Run a macro
```
qd - to add to register. the d is just a reference
…..commands….

q to stop recording

@d t0 execute

@@ to excecute again
```

# Useful strokes to remember from plugins
```
Easy Motion
,,w
,,j
,,k
,,b
,,B

Surround
ysW(
ysiwB -> surrond word with bracket
```

# Tabs/Spaces
```
TAB to SPACE
:set et
:ret!

SPACE to TAB
:set et!
:ret!

Tabs: http://cl.ly/image/2b2x1g3b0I09
```

# Visual Block Mode
`Control + V`

# Set file as modifiable
```
:set modifiable
:set ma
```
