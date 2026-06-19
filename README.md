# SSS Snake

<p align="center">
  <a href="#english">English</a> |
  <a href="#russian">Русский</a>
</p>

## Install / Установка

Quick HTTPS install and run:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
bash ./install.sh --system && \
sss
```

For a non-root user that wants a system install:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
sudo bash ./install.sh --system && \
sss
```

User install without root permissions:

```bash
mkdir -p "$HOME/src" && \
git clone https://github.com/Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
bash ./install.sh --user
```

Then run:

```bash
export PATH="$HOME/.local/bin:$PATH"
sss
```

SSH install, only if GitHub SSH access is already configured:

```bash
mkdir -p "$HOME/src" && \
git clone git@github.com:Dennitsa0-0/sss-snake.git "$HOME/src/sss-snake" && \
cd "$HOME/src/sss-snake" && \
bash ./install.sh --system && \
sss
```

Update:

```bash
cd "$HOME/src/sss-snake" && \
git pull && \
bash ./install.sh --system && \
sss
```

Uninstall:

```bash
cd "$HOME/src/sss-snake" && \
bash ./install.sh --uninstall --user
```

System uninstall:

```bash
cd "$HOME/src/sss-snake" && \
bash ./install.sh --uninstall --system
```

Repository URLs:

```text
HTTPS: https://github.com/Dennitsa0-0/sss-snake.git
SSH:   git@github.com:Dennitsa0-0/sss-snake.git
```

<a id="english"></a>

## English

SSS Snake is a low CPU SSH activity screen with an optional playable terminal snake.

The default mode is designed for long SSH sessions: it does not run AI, fruit logic, pathfinding, or high-frequency redraws. The playable snake game starts only when requested.

```text
 SSS Snake idle | session active
 host:server | load:0.08 0.03 0.01 | time:07:45:12
 status: low CPU mode | fps:0.2 | AI:off

        @----

 controls: G/Enter start game | T tmux hint | Q quit
```

[Русская версия ниже](#russian)

### Modes

```bash
sss          # low CPU idle screen for SSH
sss game     # playable snake
sss --game   # playable snake
sss watch    # minimal activity screen
sss snake    # alias for sss game
```

Idle mode:

- default for `sss`
- updates at `0.2 FPS` by default, about once every 5 seconds
- idle/watch FPS range: `0.2..1`
- no AI, no fruits, no pathfinding, no game board
- hostname is read once at startup
- load and time are refreshed at most once per frame

Game mode:

- starts with `sss game`, `sss --game`, or `sss-snake game`
- default game FPS is `5`
- game FPS is capped at `10`
- AUTO defaults to lightweight `--ai dumb`
- `--ai smart` is heavier and must be enabled explicitly

### Quick Start

Start the low CPU SSH activity screen:

```bash
sss
```

Start the playable snake:

```bash
sss game
```

Run without tmux:

```bash
sss --no-tmux
sss game --no-tmux
```

Show status and versions:

```bash
sss status
sss --version
sss-snake --version
```

Run directly:

```bash
sss-snake
sss-snake game
sss-snake watch
```

### tmux Behavior

If `tmux` is installed, `sss` starts or attaches to the `sss-snake` session automatically.

If `tmux` is missing, `sss` explains why tmux is useful and asks before installing anything. Pressing Enter means No. SSS Snake never installs packages or calls `sudo` silently.

Supported package managers:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

### Commands

```bash
sss
sss game
sss --game
sss watch
sss snake
sss status
sss --version
sss --no-tmux
sss --no-install
sss --install-tmux
sss-snake
sss-snake game
sss-snake watch
sss-snake --version
```

Launcher options:

| Option | Behavior |
| --- | --- |
| `--no-tmux` | Run the selected mode directly without checking, installing, starting, or attaching tmux. |
| `--no-install` | Use tmux if it exists. Do not ask to install it if missing. |
| `--install-tmux` | If tmux is missing, try to install it without an interactive prompt. |

Mode and game options:

| Option | Behavior |
| --- | --- |
| `--fps N` | Set frames per second. Idle/watch default: `0.2`; game default: `5`; idle/watch cap: `1`; game cap: `10`. |
| `--width N` | Set board width for game mode. |
| `--height N` | Set board height for game mode. |
| `--fruits N` | Number of fruits on the board, clamped to `1..20`. Default: `4`. |
| `--big-food` | Fruit hitboxes use radius `1`, making a 3x3 hitbox. |
| `--debug-hitbox` | Draw fruit hitboxes for debugging. |
| `--debug-ai` | Show autopilot target, next move, reason, and hitbox consistency warnings. |
| `--wrap` | Enable wrap-around edges. |
| `--no-wrap` | Keep edges as walls. Default. |
| `--ai MODE` | Game autopilot mode: `dumb`, `safe`, or `smart`. Default: `dumb`. |
| `--path-refresh N` | Rebuild smart autopilot path at most every N ticks. |
| `--lookahead N` | Safe AI lookahead depth. |
| `--open-radius N` | Radius for local open-space scoring. |
| `--memory N` | Recent head positions remembered for loop detection. |
| `--emergency-after N` | Stale ticks before emergency movement. |
| `--max-ai-cells N` | Use greedy movement above this board area. |
| `--max-ai-steps N` | Maximum BFS nodes per smart path rebuild. |
| `--idle-ticks N` | Return to autopilot after N idle ticks in manual mode. |
| `--theme NAME` | Theme: `classic`, `matrix`, `ocean`, `ember`, or `mono`. |
| `--ascii` | ASCII symbols: head `@`, body `#`, apple `o`, pear `O`, berry `*`, bonus `$`. |
| `--unicode` | Try Unicode symbols; falls back to ASCII if UTF-8 is unavailable. |
| `--no-score` | Do not read or write the high score file. |

Examples:

```bash
sss --fps 0.2
sss watch --fps 0.2
sss game --fps 5 --theme ocean --width 60 --height 18
sss game --fruits 8 --big-food
sss game --debug-ai --debug-hitbox
sss game --ai smart --path-refresh 15
sss game --ai dumb --width 80 --height 24
sss-snake game 0.20 --theme matrix
```

### Game Controls

| Key | Action |
| --- | --- |
| Arrow keys | Play manually |
| `W A S D` | Play manually |
| `T` or `Space` | Toggle autopilot/manual mode |
| `R` | Restart the board |
| `Q` | Quit |

Idle screen controls:

| Key | Action |
| --- | --- |
| `G` or Enter | Start game mode |
| `T` | Show tmux detach hint |
| `Q` | Quit |

### Environment

| Variable | Meaning |
| --- | --- |
| `SSS_TMUX_SESSION` | tmux session name, default `sss-snake` |
| `SSS_NO_TMUX=1` | Disable the tmux wrapper |
| `SSS_NO_INSTALL_PROMPT=1` | Do not ask to install tmux |
| `SSS_FPS` | Default FPS, capped by the selected mode |
| `SSS_WIDTH` | Default game board width |
| `SSS_HEIGHT` | Default game board height |
| `SSS_FRUITS` | Default game fruit count |
| `SSS_IDLE_TICKS` | Idle ticks before returning to autopilot in game mode |
| `SSS_PATH_REFRESH` | Smart autopilot path refresh interval |
| `SSS_AI` | Default game AI mode: `dumb`, `safe`, or `smart` |
| `SSS_LOOKAHEAD` | Safe AI lookahead depth |
| `SSS_OPEN_RADIUS` | Safe AI open-space scoring radius |
| `SSS_MEMORY` | Safe AI memory length |
| `SSS_EMERGENCY_AFTER` | Safe AI stale tick limit |
| `SSS_MAX_AI_CELLS` | Default max board cells for smart BFS |
| `SSS_MAX_AI_STEPS` | Default BFS node limit |
| `SSS_THEME` | Default theme |
| `SSS_ASCII=1` | Use ASCII symbols |
| `SSS_NO_SCORE=1` | Disable high score persistence |
| `NO_COLOR=1` | Disable color output |

High scores are stored in:

```text
$XDG_STATE_HOME/sss-snake/high-score
```

If `XDG_STATE_HOME` is not set:

```text
$HOME/.local/state/sss-snake/high-score
```

### Design Notes

Idle mode is intentionally boring: it is an SSH activity screen, not a Bash game loop.

Game mode uses one fruit model for rendering, hitbox checks, eating, and AI targeting. The shared lookup is `fruit_at x y`. Normal fruits use radius `0`; `--big-food` uses radius `1`.

AUTO uses `--ai dumb` by default. `--ai safe` adds local scoring, stable target selection, straight-move preference, turn penalties, recent-position penalties, and vertical oscillation penalties. `--ai smart` uses bounded BFS/path caching and is intentionally explicit.

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
- call `sudo` silently
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

[Back to top](#sss-snake)

---

<a id="russian"></a>

## Русский

SSS Snake — лёгкий экран активности для SSH-сессий с отдельной опциональной терминальной змейкой.

Обычный запуск `sss` показывает лёгкий idle-экран. Он не запускает AI, фрукты, поиск пути и частую перерисовку. Полноценная игра запускается только явно.

```text
 SSS Snake idle | session active
 host:server | load:0.08 0.03 0.01 | time:07:45:12
 status: low CPU mode | fps:0.2 | AI:off

        @----

 controls: G/Enter start game | T tmux hint | Q quit
```

[English version above](#english)

### Режимы

```bash
sss          # лёгкий idle-экран для SSH
sss game     # полноценная змейка
sss --game   # полноценная змейка
sss watch    # минимальный экран активности
sss snake    # алиас для sss game
```

Idle mode:

- режим по умолчанию для `sss`
- обновляется с `0.2 FPS` по умолчанию, примерно раз в 5 секунд
- диапазон FPS для idle/watch: `0.2..1`
- без AI, фруктов, поиска пути и игрового поля
- hostname читается один раз при запуске
- load/time обновляются не чаще одного раза за кадр

Game mode:

- запускается через `sss game`, `sss --game` или `sss-snake game`
- FPS игры по умолчанию: `5`
- максимум для игры: `10 FPS`
- AUTO по умолчанию использует лёгкий `--ai dumb`
- `--ai smart` тяжелее и включается только явно

### Быстрый старт

Запустить лёгкий SSH idle-экран:

```bash
sss
```

Запустить игру:

```bash
sss game
```

Запустить без tmux:

```bash
sss --no-tmux
sss game --no-tmux
```

Показать статус и версии:

```bash
sss status
sss --version
sss-snake --version
```

Запустить напрямую:

```bash
sss-snake
sss-snake game
sss-snake watch
```

### Поведение tmux

Если `tmux` установлен, `sss` автоматически запускает или подключает сессию `sss-snake`.

Если `tmux` не найден, `sss` объясняет, зачем он нужен, и спрашивает перед установкой. Enter означает No. SSS Snake не устанавливает пакеты и не вызывает `sudo` молча.

Поддерживаемые пакетные менеджеры:

```text
apt, dnf, yum, pacman, zypper, apk, brew
```

### Команды

```bash
sss
sss game
sss --game
sss watch
sss snake
sss status
sss --version
sss --no-tmux
sss --no-install
sss --install-tmux
sss-snake
sss-snake game
sss-snake watch
sss-snake --version
```

Флаги launcher:

| Флаг | Поведение |
| --- | --- |
| `--no-tmux` | Запустить выбранный режим напрямую, без проверки, установки, запуска или подключения tmux. |
| `--no-install` | Использовать tmux, если он есть. Не спрашивать установку, если его нет. |
| `--install-tmux` | Если tmux отсутствует, попробовать установить его без интерактивного вопроса. |

Флаги режимов и игры:

| Флаг | Поведение |
| --- | --- |
| `--fps N` | FPS. По умолчанию: idle/watch `0.2`, игра `5`; лимит idle/watch `1`, лимит игры `10`. |
| `--width N` | Ширина поля в game mode. |
| `--height N` | Высота поля в game mode. |
| `--fruits N` | Количество фруктов на поле, `1..20`. По умолчанию: `4`. |
| `--big-food` | Hitbox фруктов радиуса `1`, то есть 3x3. |
| `--debug-hitbox` | Показать hitbox фруктов для отладки. |
| `--debug-ai` | Показать цель автопилота, следующий ход, причину и предупреждения hitbox. |
| `--wrap` | Включить перенос через края поля. |
| `--no-wrap` | Использовать стены по краям поля. По умолчанию. |
| `--ai MODE` | Режим автопилота в игре: `dumb`, `safe` или `smart`. По умолчанию: `dumb`. |
| `--path-refresh N` | Пересобирать smart-маршрут не чаще чем раз в N тиков. |
| `--lookahead N` | Глубина lookahead для safe AI. |
| `--open-radius N` | Радиус оценки свободного пространства. |
| `--memory N` | Сколько последних позиций головы помнить. |
| `--emergency-after N` | Через сколько stale-тиков включать аварийное движение. |
| `--max-ai-cells N` | Использовать greedy-движение выше этой площади поля. |
| `--max-ai-steps N` | Максимум BFS-узлов на один пересчёт smart-маршрута. |
| `--idle-ticks N` | Через сколько idle-тиков ручной режим вернётся в AUTO. |
| `--theme NAME` | Тема: `classic`, `matrix`, `ocean`, `ember`, `mono`. |
| `--ascii` | ASCII-символы: голова `@`, тело `#`, apple `o`, pear `O`, berry `*`, bonus `$`. |
| `--unicode` | Попробовать Unicode; fallback на ASCII, если UTF-8 недоступен. |
| `--no-score` | Не читать и не писать файл лучшего счёта. |

Примеры:

```bash
sss --fps 0.2
sss watch --fps 0.2
sss game --fps 5 --theme ocean --width 60 --height 18
sss game --fruits 8 --big-food
sss game --debug-ai --debug-hitbox
sss game --ai smart --path-refresh 15
sss game --ai dumb --width 80 --height 24
sss-snake game 0.20 --theme matrix
```

### Управление в игре

| Клавиша | Действие |
| --- | --- |
| Стрелки | Играть вручную |
| `W A S D` | Играть вручную |
| `T` или `Space` | Переключить автопилот/ручной режим |
| `R` | Перезапустить поле |
| `Q` | Выйти |

Управление idle-экраном:

| Клавиша | Действие |
| --- | --- |
| `G` или Enter | Запустить игру |
| `T` | Показать подсказку tmux detach |
| `Q` | Выйти |

### Переменные окружения

| Переменная | Значение |
| --- | --- |
| `SSS_TMUX_SESSION` | Имя tmux-сессии, по умолчанию `sss-snake` |
| `SSS_NO_TMUX=1` | Отключить tmux-обёртку |
| `SSS_NO_INSTALL_PROMPT=1` | Не спрашивать про установку tmux |
| `SSS_FPS` | FPS по умолчанию, ограничивается выбранным режимом |
| `SSS_WIDTH` | Ширина игрового поля по умолчанию |
| `SSS_HEIGHT` | Высота игрового поля по умолчанию |
| `SSS_FRUITS` | Количество фруктов по умолчанию |
| `SSS_IDLE_TICKS` | Idle-тики до возврата в AUTO в game mode |
| `SSS_PATH_REFRESH` | Интервал пересчёта smart-маршрута |
| `SSS_AI` | Режим AI в игре по умолчанию: `dumb`, `safe` или `smart` |
| `SSS_LOOKAHEAD` | Глубина lookahead для safe AI |
| `SSS_OPEN_RADIUS` | Радиус оценки свободного пространства |
| `SSS_MEMORY` | Длина памяти recent positions |
| `SSS_EMERGENCY_AFTER` | Лимит stale-тиков для safe AI |
| `SSS_MAX_AI_CELLS` | Максимальная площадь поля для smart BFS |
| `SSS_MAX_AI_STEPS` | Лимит BFS-узлов на один пересчёт |
| `SSS_THEME` | Тема по умолчанию |
| `SSS_ASCII=1` | Использовать ASCII-символы |
| `SSS_NO_SCORE=1` | Отключить сохранение лучшего счёта |
| `NO_COLOR=1` | Отключить цвета |

Лучший счёт хранится здесь:

```text
$XDG_STATE_HOME/sss-snake/high-score
```

Если `XDG_STATE_HOME` не установлен:

```text
$HOME/.local/state/sss-snake/high-score
```

### Устройство

Idle mode намеренно скучный: это экран активности SSH, а не игровой Bash-loop.

Game mode использует единую модель фруктов для отрисовки, hitbox, поедания и выбора цели AI. Общая функция проверки — `fruit_at x y`. Обычный фрукт имеет радиус `0`; `--big-food` использует радиус `1`.

AUTO по умолчанию использует `--ai dumb`. `--ai safe` добавляет локальную оценку ходов, стабильную цель, бонус за прямое движение, штрафы за повороты, recent-position penalty и штраф за вертикальное дёргание. `--ai smart` использует ограниченный BFS и кэш маршрута, поэтому включается только явно.

### Рекомендуемый SSH Keepalive

SSS Snake не заменяет SSH keepalive. Он хорошо сочетается с tmux и короткой настройкой SSH-клиента:

```sshconfig
Host *
    ServerAliveInterval 30
    ServerAliveCountMax 4
```

### Безопасность

SSS Snake не делает этого:

- не устанавливает tmux без подтверждения при обычном запуске `sss`
- не вызывает `sudo` молча
- не меняет `.bashrc`, `.profile` или `.zshrc`
- не добавляет автозапуск
- не удаляет пакеты
- не запускает обновление системы
- не скачивает сторонние бинарники
- не выполняет `curl | bash`

Единственный пакет, который `sss` может попробовать установить, — это `tmux`, и только после явного подтверждения или флага `--install-tmux`.

### Чем SSS Snake не является

- Не замена tmux
- Не монитор сервера
- Не daemon и не systemd service
- Не гарантия вечного SSH-подключения

[Наверх](#sss-snake)
