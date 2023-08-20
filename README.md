# Tmux Configuration

This repository contains my custom Tmux configuration, designed to enhance terminal multiplexing and complement my development environment.

## Installation & Setup

### DEPS:

Install `tmp` into home dir:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Confirm with

```bash
which tpm
```

### Location:

Place the configuration in the following directory:

```javascript
~/.config/tmux
```

### Initialization:

1. Navigate to the Tmux configuration directory:

```bash
$ cd ~/.config/tmux
```

2. Start Tmux:

```bash
$ tmux
```

3. Open the configuration in NeoVim:

```bash
$ nvim .
```

4. Inside `tmux.conf`, perform the following:

- `<tmux_prefix> I`: Install plugins.
- `<tmux_prefix> d`: Detach from the Tmux session.

5. Source the Tmux configuration:

```bash
$ tmux source ~/.config/tmux/tmux.conf
```

## Related Configurations

For an integrated development experience, check out my [NeoVim configuration](https://github.com/ctheil/nvim-config) which complements this Tmux setup.---
