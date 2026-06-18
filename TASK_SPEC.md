# SSS Snake Specification

## 1. Purpose

SSS Snake is a small Bash terminal utility for long SSH sessions.

Project naming:

- repository name: `sss-snake`
- launcher binary: `sss`
- game binary: `sss-snake`
- default tmux session: `sss-snake`

The project should feel simple to a new user:

```bash
sss
```

That single command should start the game, use tmux when it is useful, and continue to work even when tmux is not available.

## 2. Goals

- Provide a clean terminal activity screen for SSH sessions.
- Avoid scrollback spam by redrawing one terminal screen.
- Run with Bash and standard Unix terminal tools only.
- Start safely through tmux when tmux is installed.
- Keep working without tmux.
- Offer a playable snake game with an autopilot idle mode.
- Be suitable for a public GitHub repository with clear install and usage docs.

## 3. Non-Goals

- SSS Snake is not a tmux replacement.
- It is not a server monitor.
- It is not a daemon or systemd service.
- It does not guarantee SSH connections will stay alive.
- It does not modify user shell startup files.

## 4. Commands

### 4.1. `sss`

`sss` is the main user-facing launcher.

Behavior:

1. If the user is already inside tmux, run `sss-snake` directly.
2. If tmux is installed and the user is not inside tmux, run or attach:

   ```bash
   tmux new-session -A -s sss-snake sss-snake
   ```

3. If tmux is missing, explain why it is recommended and ask whether to install it.
4. If the user accepts, install only the `tmux` package through a supported package manager.
5. If installation succeeds, start the game inside tmux.
6. If installation fails or the user declines, run `sss-snake` directly.

Examples:

```bash
sss
sss snake
sss status
sss --version
sss --no-tmux
sss --no-install
sss --install-tmux
sss --theme ocean --width 60
```

### 4.2. `sss status`

`sss status` prints launcher diagnostics:

- whether tmux is installed
- whether the command is already inside tmux
- the configured tmux session name
- whether the tmux wrapper is disabled
- whether the install prompt is disabled
- whether score persistence is disabled
- where `sss-snake` resolves from `PATH`

### 4.3. `sss-snake`

`sss-snake` runs the game directly.

Examples:

```bash
sss-snake
sss-snake --version
sss-snake 0.20
sss-snake --theme matrix --width 70 --height 20
```

## 5. First-Run tmux Bootstrap

The launcher must not assume that users know tmux.

When tmux is missing, normal `sss` launches show:

```text
tmux is not installed.

SSS Snake can work without tmux, but tmux is recommended.
It keeps your terminal session alive on the server even if SSH disconnects.

Install tmux now? [y/N]
```

Default answer is No. Pressing Enter must not install anything.

Accepted Yes answers:

- `y`
- `Y`
- `yes`
- `YES`

Accepted No answers:

- `n`
- `N`
- `no`
- `NO`
- Enter

Unknown answers are treated as No:

```text
Unknown answer. Continuing without tmux.
```

### 5.1. Package Managers

Package managers are detected in this order:

1. `apt`
2. `dnf`
3. `yum`
4. `pacman`
5. `zypper`
6. `apk`
7. `brew`

Install commands:

| Manager | Command |
| --- | --- |
| `apt` | `apt install -y tmux` |
| `dnf` | `dnf install -y tmux` |
| `yum` | `yum install -y tmux` |
| `pacman` | `pacman -S --noconfirm tmux` |
| `zypper` | `zypper install -y tmux` |
| `apk` | `apk add tmux` |
| `brew` | `brew install tmux` |

If no supported package manager is found:

```text
Could not detect a supported package manager.
Please install tmux manually, or run SSS Snake without tmux.
```

Then the game runs directly.

### 5.2. sudo

If the selected package manager needs administrator permissions and the process is not running as root, the launcher uses `sudo`.

Before calling `sudo`, it prints:

```text
Installing tmux requires administrator permissions.
You may be asked for your sudo password.
```

If `sudo` is not available:

```text
sudo is not available.
Please install tmux manually, or run SSS Snake without tmux.
```

Then the game runs directly.

### 5.3. Installation Failure

If the user agreed to install tmux but installation failed:

```text
tmux installation failed.
Continuing without tmux.
```

Then the game runs directly.

### 5.4. Launcher Flags

`sss --no-tmux`

- Do not check tmux.
- Do not ask to install tmux.
- Run `sss-snake` directly.

`sss --no-install`

- Use tmux if it exists.
- Do not ask to install tmux if missing.
- Run directly if tmux is missing.

`sss --install-tmux`

- Use tmux if it exists.
- If tmux is missing, attempt installation without an interactive prompt.
- Run directly if installation fails.

`SSS_NO_INSTALL_PROMPT`

- If set to any value, `sss` does not ask to install tmux.
- This is equivalent to the no-prompt part of `--no-install`.

## 6. Safety Requirements

The utility must not:

- silently install packages
- silently call `sudo`
- modify `.bashrc`, `.profile`, or `.zshrc`
- add shell autostart
- remove packages
- run full system upgrades
- run `apt upgrade`, `dnf upgrade`, `pacman -Syu`, or equivalent
- download third-party binaries
- run `curl | bash`

Allowed operations:

- check whether `tmux` exists
- ask whether to install `tmux`
- install only the `tmux` package after confirmation or `--install-tmux`
- continue without tmux on failure
- write the game high score under the user state directory

## 7. Game Behavior

### 7.1. Autopilot

- Autopilot is enabled by default.
- The snake follows a deterministic safe route across the board.
- Apples appear in random empty cells.
- The snake eventually reaches apples without self-colliding in autopilot mode.
- The screen shows how many apples were eaten while the user was away.

### 7.2. Manual Mode

The user can take control at any time:

- arrow keys
- `W A S D`
- `T` or `Space` to toggle mode

When manual mode starts:

- mode changes to `PLAY`
- the current away counter is preserved as `away ate`
- the user controls the snake immediately

Manual mode uses wrap-around edges.

### 7.3. Returning To Autopilot

- Pressing `T` or `Space` returns to autopilot.
- If manual mode is idle for `SSS_IDLE_TICKS`, the game returns to autopilot automatically.
- Before returning, the snake normalizes back onto the safe route.

### 7.4. Collisions

- Self-collision restarts the board.
- Total score is kept.
- The restart counter increases.

## 8. Game Interface

The screen should show:

- title
- mode: `AUTO` or `PLAY`
- hostname
- load average when `/proc/loadavg` is available
- current time
- total score
- manual score
- away/autopilot score
- restart count
- best score
- controls
- board

The game should use the alternate screen buffer and restore terminal state on exit.

## 9. Game Options

`sss-snake [delay]`

- Delay is frame delay in seconds.
- Default is `0.12`.

`--width N`

- Board width.
- Clamped to `20..100`.

`--height N`

- Board height.
- Clamped to `10..40`.

`--idle-ticks N`

- Number of idle manual ticks before autopilot resumes.

`--theme NAME`

Supported themes:

- `classic`
- `matrix`
- `ocean`
- `ember`
- `mono`

`--ascii`

- Use ASCII symbols.

`--unicode`

- Use Unicode symbols through Bash escape sequences.

`--no-score`

- Disable high score reads and writes.

## 10. Environment Variables

| Variable | Meaning |
| --- | --- |
| `SSS_TMUX_SESSION` | tmux session name, default `sss-snake` |
| `SSS_NO_TMUX=1` | Disable tmux wrapper |
| `SSS_NO_INSTALL_PROMPT` | Disable tmux install prompt when set |
| `SSS_WIDTH` | Default board width |
| `SSS_HEIGHT` | Default board height |
| `SSS_IDLE_TICKS` | Idle ticks before returning to autopilot |
| `SSS_THEME` | Default theme |
| `SSS_ASCII=1` | Use ASCII symbols |
| `SSS_NO_SCORE=1` | Disable high score persistence |
| `NO_COLOR=1` | Disable colors |

## 11. Persistence

High score is stored at:

```text
$XDG_STATE_HOME/sss-snake/high-score
```

If `XDG_STATE_HOME` is not set:

```text
$HOME/.local/state/sss-snake/high-score
```

Failure to read or write the score file must not stop the game.

## 12. Repository Structure

```text
sss-snake/
|-- .github/
|   `-- workflows/
|       `-- ci.yml
|-- bin/
|   |-- sss
|   `-- sss-snake
|-- docs/
|   `-- ARCHITECTURE.md
|-- install.sh
|-- Makefile
|-- README.md
|-- TASK_SPEC.md
|-- CHANGELOG.md
|-- .gitignore
`-- LICENSE
```

## 13. GitHub Install Requirements

Users must be able to open the README, copy one command block, paste it into a server terminal, and end with a working `sss` command.

Repository URLs:

```text
HTTPS: https://github.com/Dennitsa0-0/sss-snake.git
SSH:   git@github.com:Dennitsa0-0/sss-snake.git
```

The HTTPS URL is the default for normal users. The SSH URL is for users with a configured GitHub SSH key.

Default source checkout path:

```text
$HOME/src/sss-snake
```

README must include HTTPS install:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

README must include SSH install:

```bash
mkdir -p "$HOME/src" && \
git clone git@github.com:Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

README should also include a copy-paste install-and-run command that temporarily adds `$HOME/.local/bin` to `PATH` for the current shell:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh && \
export PATH="$HOME/.local/bin:$PATH" && \
sss
```

Default install prefix:

```text
$HOME/.local
```

Default installed files:

```text
$HOME/.local/bin/sss
$HOME/.local/bin/sss-snake
```

`install.sh` must:

1. determine the install prefix;
2. create `$prefix/bin` when missing;
3. copy `bin/sss` to `$prefix/bin/sss`;
4. copy `bin/sss-snake` to `$prefix/bin/sss-snake`;
5. set executable mode `0755`;
6. optionally create `$HOME/.local/state/sss-snake`;
7. check whether `$prefix/bin` is in `PATH`;
8. print a clear `PATH` hint when needed;
9. print:

   ```text
   Installed SSS Snake to $HOME/.local/bin
   Run: sss
   ```

The installer must not modify `.bashrc`, `.profile`, or `.zshrc`.

The installer must not call `sudo` for its own installation. If a custom prefix such as `/usr/local` needs administrator permissions, the user runs:

```bash
sudo ./install.sh --prefix /usr/local
```

Update command:

```bash
cd "$HOME/src/sss-snake" && \
git pull && \
./install.sh
```

Uninstall command:

```bash
./install.sh --uninstall
```

Custom prefix uninstall:

```bash
./install.sh --uninstall --prefix /usr/local
```

Uninstall must not remove the source checkout under `$HOME/src/sss-snake`.

## 14. README Language Requirements

The project must use a single bilingual `README.md`.

The README must start with a language switch:

- `English`
- `Русский`

The English section must go first.

The Russian section must be available through an explicit anchor link from the top of the file.

The README must not mix English and Russian line-by-line. Each language should have its own complete section.

Use explicit HTML anchors:

```md
<a id="english"></a>
## English

<a id="russian"></a>
## Русский
```

The README should include:

- demo preview or real demo asset
- short "Why?" explanation
- `Install / Установка` block with HTTPS install, SSH install, run, update, uninstall, and `PATH` note
- quick start
- controls
- tmux behavior
- safety section
- "What SSS Snake is not"
- recommended SSH keepalive
- `sss --version` and `sss-snake --version`

## 15. Release Files

The repository should include:

- `CHANGELOG.md`
- GitHub Actions workflow with Bash syntax check and ShellCheck
- `.gitignore` for local editor and virtual environment files

## 16. Acceptance Criteria

The utility is ready when:

1. `sss` starts the game with one command.
2. Users do not need to know tmux.
3. If tmux is installed, `sss` runs the game inside tmux.
4. If tmux is missing, normal `sss` asks a clear install question.
5. Pressing Enter does not install tmux.
6. Installation starts only after explicit Yes or `--install-tmux`.
7. `apt`, `dnf`, `yum`, `pacman`, `zypper`, `apk`, and `brew` are supported.
8. Failed tmux installation falls back to direct game launch.
9. `--no-tmux` works.
10. `--no-install` works.
11. `--install-tmux` works.
12. `sss status` works.
13. `sss --version` works.
14. `sss-snake --version` works.
15. Board width and height can be configured.
16. Color themes work and `NO_COLOR` disables colors.
17. High score persistence works and can be disabled.
18. The command does not modify shell config files.
19. The command does not run system upgrades.
20. The command does not use `curl | bash`.
21. `sss --help` documents launcher behavior.
22. `sss-snake --help` documents game behavior.
23. README is a single bilingual file with English first and Russian second.
24. CI checks Bash syntax and ShellCheck.
25. README contains HTTPS and SSH GitHub install commands.
26. README contains an update command based on `git pull`.
27. README contains an uninstall command.
28. `install.sh` creates `$HOME/.local/bin` when needed.
29. `install.sh` prints a clear `PATH` hint instead of editing shell config.
30. `install.sh` does not call `sudo` for its own installation.
