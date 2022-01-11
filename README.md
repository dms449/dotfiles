# Dotfiles
Install everything or just some things. Choose between actually installing vs 
simply symlinking.

## Installation

To install everything, use the 'install' command with no parameters
```
bash ./setup.sh install
```

To install some things
```
bash ./setup.sh install nvim tmux
```

## Setup
to only redo the copying and symlinking of config files but not the installing 
replace 'install' with 'setup'. 
```
bash ./setup.sh setup 

```

## Conglomerates
Treated like applications in the examples above ('tmux' or 'nvim'), conglomerates
exist to avoid installing unnecessary applications, plugins, configs, etc. when 
they are not needed.

For Example.
If you are not doing web development this greatly decreases the amount of 
applications, plugins, etc. that you will need. Thus, all things web development 
are broken out separately and can be install like 
```
bash ./setup.sh install web-development
```

Conglomerates will also still be installed if no parameters are passed in.
