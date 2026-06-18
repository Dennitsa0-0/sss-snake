# Architecture

SSS Snake is intentionally small. It has two executable Bash scripts and no runtime dependency on Python, Node.js, Go, Rust, or curses.

## `bin/sss`

`sss` is the main entrypoint.

Responsibilities:

- parse `sss` commands such as `snake` and `status`
- parse `sss` flags such as `--no-tmux`, `--no-install`, and `--install-tmux`
- pass game flags through to `sss-snake`
- detect whether the process is already inside tmux
- detect whether `tmux` is installed
- start or attach the configured tmux session
- safely offer first-run tmux installation when tmux is missing
- fall back to direct game launch when tmux is unavailable

The default tmux session name is `sss-snake` and can be changed with `SSS_TMUX_SESSION`.

`sss` does not modify shell startup files, add autostart, upgrade the system, remove packages, download binaries, or run `curl | bash`.

## tmux Bootstrap

When tmux is missing, `sss` asks before installing anything. The normal prompt defaults to No.

Supported package managers are checked in this order:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

For non-root Linux package managers, `sss` uses `sudo` only after printing a short warning. If `sudo` is unavailable or installation fails, `sss` runs the game directly.

## `bin/sss-snake`

`sss-snake` is the game.

Responsibilities:

- parse game options
- size the board from terminal dimensions, environment, or CLI flags
- switch into the alternate screen buffer
- save and restore terminal state
- read keyboard input without blocking the animation loop
- draw the board in place
- run autopilot and manual movement
- persist the high score when enabled

The game requires Bash 4+ for associative arrays.

## Game Loop

The game uses a simple loop:

1. Draw the current frame.
2. Read one key with a timeout equal to the frame delay.
3. Apply manual input if present.
4. Step autopilot or manual movement.
5. Repeat until quit is requested.

`trap cleanup EXIT INT TERM` restores terminal state and writes the high score when needed.

## Autopilot

Autopilot follows a deterministic serpentine route over the whole board. This route is stored as arrays of x/y coordinates plus an index lookup map.

Because the snake follows a full-board route, it eventually reaches any apple while avoiding itself. When manual mode has been idle for long enough, the current snake is normalized back onto this route and autopilot resumes.

## Rendering

The game uses:

- `tput smcup` and `tput rmcup` for the alternate screen buffer
- `tput cup` for cursor positioning
- `tput civis` and `tput cnorm` for cursor visibility
- `tput setaf` for colors when available
- `NO_COLOR` to disable colors

No curses library is required.

## Persistence

The high score is stored in the XDG state directory:

```text
$XDG_STATE_HOME/sss-snake/high-score
```

If `XDG_STATE_HOME` is not set:

```text
$HOME/.local/state/sss-snake/high-score
```

Read or write failures are ignored so the game never fails because of score persistence.
