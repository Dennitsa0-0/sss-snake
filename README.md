# SSS Snake

<p align="center">
  <a href="#english">English</a> |
  <a href="#russian">Русский</a>
</p>

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
- A POSIX-like terminal
- Standard terminal tools such as `tput`, `stty`, `date`, and `hostname`
- `tmux` is recommended, but optional

### Install

Install for the current user:

```bash
./install.sh
```

Install to a custom prefix:

```bash
./install.sh --prefix /usr/local
```

Or use Make:

```bash
make install PREFIX="$HOME/.local"
```

Make sure the install directory is in `PATH`, for example:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Uninstall:

```bash
./install.sh --uninstall
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

Show launcher status:

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

The `sss` launcher is designed for people who do not know or care what tmux is.

When `tmux` is installed, `sss` starts or attaches to a session named `sss-snake`.

When `tmux` is missing, `sss` explains why it is useful and asks before installing anything:

```text
tmux is not installed.

SSS Snake can work without tmux, but tmux is recommended.
It keeps your terminal session alive on the server even if SSH disconnects.

Install tmux now? [y/N]
```

Pressing Enter means No. The launcher never installs packages or calls `sudo` silently.

Supported package managers, checked in order:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

If installation fails, or if the user declines, SSS Snake runs directly in the current terminal.

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

Launcher options:

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

The only package installation attempted by the launcher is the `tmux` package, and only after explicit confirmation or `--install-tmux`.

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
- POSIX-подобный терминал
- Стандартные терминальные утилиты: `tput`, `stty`, `date`, `hostname`
- `tmux` рекомендуется, но не обязателен

### Установка

Для текущего пользователя:

```bash
./install.sh
```

С другим prefix:

```bash
./install.sh --prefix /usr/local
```

Через Make:

```bash
make install PREFIX="$HOME/.local"
```

Убедитесь, что директория установки есть в `PATH`, например:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Удаление:

```bash
./install.sh --uninstall
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

Показать статус launcher:

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

`sss` сделан так, чтобы пользователю не нужно было заранее знать tmux.

Если `tmux` установлен, `sss` запускает или подключает сессию `sss-snake`.

Если `tmux` не найден, `sss` коротко объясняет, зачем он нужен, и спрашивает перед установкой:

```text
tmux is not installed.

SSS Snake can work without tmux, but tmux is recommended.
It keeps your terminal session alive on the server even if SSH disconnects.

Install tmux now? [y/N]
```

Enter означает No. Launcher не устанавливает пакеты и не вызывает `sudo` молча.

Поддерживаемые пакетные менеджеры, порядок проверки:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

Если установка не удалась или пользователь отказался, SSS Snake запускается прямо в текущем терминале.

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

Флаги launcher:

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

Единственная установка пакета, которую может попробовать launcher, - это установка пакета `tmux`, только после явного подтверждения или флага `--install-tmux`.

### Чем SSS Snake не является

- Не замена tmux
- Не монитор сервера
- Не daemon и не systemd service
- Не гарантия вечного SSH-подключения

### Устройство

Автопилот идет по детерминированному маршруту по всему полю. Он со временем добирается до любого яблока и не врезается в себя. Ручной режим работает как обычная змейка с переносом через края поля. Если ручной режим долго остается без ввода, игра нормализует змейку обратно на безопасный маршрут автопилота и продолжает.

[Наверх](#sss-snake)
