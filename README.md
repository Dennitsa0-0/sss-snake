# SSS Snake

<p align="center">
  <a href="#english">English</a> |
  <a href="#russian">Русский</a>
</p>

## Install / Установка

Quick HTTPS install and run:

Use HTTPS if you just want to install SSS Snake.
Use SSH if your GitHub SSH key is already configured.

Используйте HTTPS для обычной установки.
Используйте SSH только если на сервере уже настроен GitHub SSH-ключ.

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh && \
export PATH="$HOME/.local/bin:$PATH" && \
sss
```

SSH install, if you already have a GitHub SSH key configured:

```bash
mkdir -p "$HOME/src" && \
git clone git@github.com:Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

Repository URLs:

```text
HTTPS: https://github.com/Dennitsa0-0/sss-snake.git
SSH:   git@github.com:Dennitsa0-0/sss-snake.git
```

Run after install:

```bash
sss
```

If `sss` is not found yet:

```bash
"$HOME/.local/bin/sss"
```

Add this line to your shell profile for future terminals:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Update:

```bash
cd "$HOME/src/sss-snake" && \
git pull && \
./install.sh
```

Uninstall:

```bash
cd "$HOME/src/sss-snake" && \
./install.sh --uninstall
```

<a id="english"></a>

## English

SSS Snake is a tiny self-playing terminal snake for long SSH sessions.

Leave your SSH terminal open. The snake plays itself, keeps the screen alive, and lets you take control when you come back.

```text
 SSS Snake  mode:AUTO  host:server  load:0.08 0.03 0.01
 total:42  manual:3  auto ate:12  restarts:0  best:87
 controls: arrows/WASD play | T/Space auto/manual | R restart | Q quit
 +----------------------------+
 | Ooo        *               |
 |                            |
 |                            |
 |                            |
 +----------------------------+
```

[Русская версия ниже](#russian)

### Features

- One-command launch with `sss`
- Safe first-run tmux bootstrap
- Works without tmux when tmux is unavailable
- Autopilot mode for idle sessions
- Manual play with arrows or `W A S D`
- Color themes with `NO_COLOR` support
- Configurable board size
- Persistent high score
- Bash only: no Python, Node.js, Go, Rust, or curses dependency

### Requirements

- Bash 4+
- `git` for GitHub install
- A POSIX-like terminal
- Standard terminal tools such as `tput`, `stty`, `date`, and `hostname`
- `tmux` is recommended, but optional

Install `git` first if it is missing:

Debian/Ubuntu:

```bash
sudo apt install git
```

Fedora:

```bash
sudo dnf install git
```

Arch:

```bash
sudo pacman -S git
```

### Install

HTTPS install, recommended for normal installation:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

SSH install, only if your GitHub SSH key is already configured:

```bash
mkdir -p "$HOME/src" && \
git clone git@github.com:Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

Run:

```bash
sss
```

If `sss` is not found yet, run it directly:

```bash
"$HOME/.local/bin/sss"
```

Then add this line to your shell profile for future terminals:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Update:

```bash
cd "$HOME/src/sss-snake" && \
git pull && \
./install.sh
```

Install to a custom prefix:

```bash
./install.sh --prefix /usr/local
```

If that prefix requires administrator permissions, run the installer yourself with `sudo`:

```bash
sudo ./install.sh --prefix /usr/local
```

The installer does not call `sudo` for its own installation.

Uninstall from the default prefix:

```bash
./install.sh --uninstall
```

Uninstall from a custom prefix:

```bash
./install.sh --uninstall --prefix /usr/local
```

### Quick Start

Start SSS Snake:

```bash
sss
```

From a source checkout:

```bash
./bin/sss
```

Run without tmux:

```bash
sss --no-tmux
```

Show `sss` status:

```bash
sss status
```

Show versions:

```bash
sss --version
sss-snake --version
```

Run the game directly:

```bash
sss-snake
```

### tmux Behavior

You do not need to know tmux before running SSS Snake.

If `tmux` is installed, `sss` starts or attaches to the `sss-snake` session automatically.

If `tmux` is missing, `sss` briefly explains why it is useful and asks before installing anything:

```text
tmux is not installed.

SSS Snake can work without tmux, but tmux is recommended.
It keeps your terminal session alive on the server even if SSH disconnects.

Install tmux now? [y/N]
```

Pressing Enter means No. `sss` never installs packages or calls `sudo` silently.

Supported package managers, checked in order:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

If installation fails, or if you choose not to install tmux, SSS Snake runs directly in the current terminal.

### Commands

```bash
sss
sss snake
sss status
sss --version
sss --no-tmux
sss --no-install
sss --install-tmux
sss-snake
sss-snake --version
```

`sss` options:

| Option | Behavior |
| --- | --- |
| `--no-tmux` | Do not check, install, start, or attach tmux. Run the game directly. |
| `--no-install` | Use tmux if it exists. Do not ask to install it if missing. |
| `--install-tmux` | If tmux is missing, try to install it without an interactive prompt. |

Game options:

| Option | Behavior |
| --- | --- |
| `--width N` | Set board width, clamped to `20..100`. |
| `--height N` | Set board height, clamped to `10..40`. |
| `--idle-ticks N` | Return to autopilot after N idle ticks in manual mode. |
| `--theme NAME` | Use `classic`, `matrix`, `ocean`, `ember`, or `mono`. |
| `--ascii` | Use ASCII board symbols. |
| `--unicode` | Use Unicode board symbols. |
| `--no-score` | Do not read or write the high score file. |

Examples:

```bash
sss --theme ocean --width 60 --height 18
sss --no-install --theme mono --ascii
sss-snake 0.20 --theme matrix
```

### Controls

| Key | Action |
| --- | --- |
| Arrow keys | Play manually |
| `W A S D` | Play manually |
| `T` or `Space` | Toggle autopilot/manual mode |
| `R` | Restart the board |
| `Q` | Quit |

### Environment

| Variable | Meaning |
| --- | --- |
| `SSS_TMUX_SESSION` | tmux session name, default `sss-snake` |
| `SSS_NO_TMUX=1` | Disable the tmux wrapper |
| `SSS_NO_INSTALL_PROMPT=1` | Do not ask to install tmux |
| `SSS_WIDTH` | Default board width |
| `SSS_HEIGHT` | Default board height |
| `SSS_IDLE_TICKS` | Idle ticks before returning to autopilot |
| `SSS_THEME` | Default theme |
| `SSS_ASCII=1` | Use ASCII symbols |
| `SSS_NO_SCORE=1` | Disable high score persistence |
| `NO_COLOR=1` | Disable colors |

High scores are stored in:

```text
$XDG_STATE_HOME/sss-snake/high-score
```

If `XDG_STATE_HOME` is not set, SSS Snake uses:

```text
$HOME/.local/state/sss-snake/high-score
```

### Recommended SSH Keepalive

SSS Snake does not replace SSH keepalive. It pairs well with tmux and a small SSH client config:

```sshconfig
Host *
    ServerAliveInterval 30
    ServerAliveCountMax 4
```

### Safety

SSS Snake does not:

- install tmux without confirmation during normal `sss` launches
- call `sudo` without warning
- modify `.bashrc`, `.profile`, or `.zshrc`
- add shell autostart
- remove packages
- run system upgrades
- download third-party binaries
- run `curl | bash`

The only package installation `sss` can attempt is `tmux`, and only after explicit confirmation or `--install-tmux`.

### What SSS Snake Is Not

- Not a tmux replacement
- Not a server monitor
- Not a daemon or systemd service
- Not a guarantee that SSH will stay connected forever

### Design

Autopilot follows a deterministic route over the whole board. It eventually reaches every apple while avoiding self-collisions. Manual mode behaves like a regular snake with wrap-around edges. If manual mode is left idle, the game normalizes the snake back onto the safe autopilot route and continues.

[Back to top](#sss-snake)

---

<a id="russian"></a>

## Русский

SSS Snake - маленькая самоиграющая змейка для долгих SSH-сессий.

Оставил SSH-сессию открытой - змейка сама играет, держит терминал живым и показывает, сколько яблок собрала, пока тебя не было. Вернулся - взял управление.

```text
 SSS Snake  mode:AUTO  host:server  load:0.08 0.03 0.01
 total:42  manual:3  auto ate:12  restarts:0  best:87
 controls: arrows/WASD play | T/Space auto/manual | R restart | Q quit
 +----------------------------+
 | Ooo        *               |
 |                            |
 |                            |
 |                            |
 +----------------------------+
```

[English version above](#english)

### Возможности

- Запуск одной командой `sss`
- Безопасная первая настройка tmux
- Работа без tmux, если tmux недоступен
- Автопилот для оставленной SSH-сессии
- Ручное управление стрелками или `W A S D`
- Цветовые темы и поддержка `NO_COLOR`
- Настраиваемый размер поля
- Сохранение лучшего счета
- Только Bash: без Python, Node.js, Go, Rust и curses

### Требования

- Bash 4+
- `git` для установки из GitHub
- POSIX-подобный терминал
- Стандартные терминальные утилиты: `tput`, `stty`, `date`, `hostname`
- `tmux` рекомендуется, но не обязателен

Если `git` не установлен, сначала установите его:

Debian/Ubuntu:

```bash
sudo apt install git
```

Fedora:

```bash
sudo dnf install git
```

Arch:

```bash
sudo pacman -S git
```

### Установка

Установка через HTTPS, рекомендуемый вариант для обычной установки:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

Установка через SSH, только если на сервере уже настроен GitHub SSH-ключ:

```bash
mkdir -p "$HOME/src" && \
git clone git@github.com:Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
./install.sh
```

Запуск:

```bash
sss
```

Если `sss` пока не найден, запустите напрямую:

```bash
"$HOME/.local/bin/sss"
```

Потом добавьте эту строку в shell profile для будущих терминалов:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Обновление:

```bash
cd "$HOME/src/sss-snake" && \
git pull && \
./install.sh
```

Установка в другой prefix:

```bash
./install.sh --prefix /usr/local
```

Если для prefix нужны права администратора, запустите установщик через `sudo` сами:

```bash
sudo ./install.sh --prefix /usr/local
```

Установщик не вызывает `sudo` для собственной установки.

Удаление из prefix по умолчанию:

```bash
./install.sh --uninstall
```

Удаление из другого prefix:

```bash
./install.sh --uninstall --prefix /usr/local
```

### Быстрый старт

Запустить SSS Snake:

```bash
sss
```

Из исходников:

```bash
./bin/sss
```

Запустить без tmux:

```bash
sss --no-tmux
```

Показать статус `sss`:

```bash
sss status
```

Показать версии:

```bash
sss --version
sss-snake --version
```

Запустить игру напрямую:

```bash
sss-snake
```

### Поведение tmux

Вам не нужно заранее знать tmux, чтобы запустить SSS Snake.

Если `tmux` установлен, `sss` автоматически запускает или подключает сессию `sss-snake`.

Если `tmux` не найден, `sss` коротко объясняет, зачем он нужен, и спрашивает перед установкой:

```text
tmux is not installed.

SSS Snake can work without tmux, but tmux is recommended.
It keeps your terminal session alive on the server even if SSH disconnects.

Install tmux now? [y/N]
```

Enter означает No. `sss` не устанавливает пакеты и не вызывает `sudo` молча.

Поддерживаемые пакетные менеджеры, порядок проверки:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

Если установка не удалась или вы решили не устанавливать tmux, SSS Snake запускается прямо в текущем терминале.

### Команды

```bash
sss
sss snake
sss status
sss --version
sss --no-tmux
sss --no-install
sss --install-tmux
sss-snake
sss-snake --version
```

Флаги `sss`:

| Флаг | Поведение |
| --- | --- |
| `--no-tmux` | Не проверять, не ставить и не запускать tmux. Сразу запустить игру напрямую. |
| `--no-install` | Использовать tmux, если он есть. Не спрашивать установку, если его нет. |
| `--install-tmux` | Если tmux отсутствует, попробовать установить его без интерактивного вопроса. |

Флаги игры:

| Флаг | Поведение |
| --- | --- |
| `--width N` | Ширина поля, ограничивается диапазоном `20..100`. |
| `--height N` | Высота поля, ограничивается диапазоном `10..40`. |
| `--idle-ticks N` | Через сколько idle-тиков ручной режим вернется в автопилот. |
| `--theme NAME` | Тема: `classic`, `matrix`, `ocean`, `ember`, `mono`. |
| `--ascii` | Использовать ASCII-символы. |
| `--unicode` | Использовать Unicode-символы. |
| `--no-score` | Не читать и не писать файл лучшего счета. |

Примеры:

```bash
sss --theme ocean --width 60 --height 18
sss --no-install --theme mono --ascii
sss-snake 0.20 --theme matrix
```

### Управление

| Клавиша | Действие |
| --- | --- |
| Стрелки | Играть вручную |
| `W A S D` | Играть вручную |
| `T` или `Space` | Переключить автопилот/ручной режим |
| `R` | Перезапустить поле |
| `Q` | Выйти |

### Переменные окружения

| Переменная | Значение |
| --- | --- |
| `SSS_TMUX_SESSION` | Имя tmux-сессии, по умолчанию `sss-snake` |
| `SSS_NO_TMUX=1` | Отключить tmux-обертку |
| `SSS_NO_INSTALL_PROMPT=1` | Не спрашивать про установку tmux |
| `SSS_WIDTH` | Ширина поля по умолчанию |
| `SSS_HEIGHT` | Высота поля по умолчанию |
| `SSS_IDLE_TICKS` | Idle-тики до возврата в автопилот |
| `SSS_THEME` | Тема по умолчанию |
| `SSS_ASCII=1` | Использовать ASCII-символы |
| `SSS_NO_SCORE=1` | Отключить сохранение лучшего счета |
| `NO_COLOR=1` | Отключить цвета |

Лучший счет хранится здесь:

```text
$XDG_STATE_HOME/sss-snake/high-score
```

Если `XDG_STATE_HOME` не установлен:

```text
$HOME/.local/state/sss-snake/high-score
```

### Рекомендуемый SSH Keepalive

SSS Snake не заменяет SSH keepalive. Он хорошо работает вместе с tmux и короткой настройкой SSH-клиента:

```sshconfig
Host *
    ServerAliveInterval 30
    ServerAliveCountMax 4
```

### Безопасность

SSS Snake не делает этого:

- не устанавливает tmux без подтверждения при обычном запуске `sss`
- не вызывает `sudo` без предупреждения
- не меняет `.bashrc`, `.profile` или `.zshrc`
- не добавляет автозапуск
- не удаляет пакеты
- не запускает обновление системы
- не скачивает сторонние бинарники
- не выполняет `curl | bash`

Единственный пакет, который может попробовать установить `sss`, - это `tmux`, и только после явного подтверждения или флага `--install-tmux`.

### Чем SSS Snake не является

- Не замена tmux
- Не монитор сервера
- Не daemon и не systemd service
- Не гарантия вечного SSH-подключения

### Устройство

Автопилот идет по детерминированному маршруту по всему полю. Он со временем добирается до любого яблока и не врезается в себя. Ручной режим работает как обычная змейка с переносом через края поля. Если ручной режим долго остается без ввода, игра нормализует змейку обратно на безопасный маршрут автопилота и продолжает.

[Наверх](#sss-snake)
