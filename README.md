# Elixir

Proyectos en **Elixir**, ejecutados sobre la **BEAM** (Erlang VM).

Usa `mix.exs` como manifiesto de proyecto, **Mix** como herramienta de construcción y **ExUnit** como framework de pruebas unitarias (incluido en el lenguaje).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `calculator`, `numbers` |
| [`core/algorithms/`](core/algorithms/) | **Fase 1 — Algoritmos Puros**: `naive_sort` |

---

### ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
elixir hello_world.exs

# Hello, User!
cd core/foundations/hellouser
elixir hello_user.exs

# Calculator Tests
cd core/foundations/unit_test/calculator
mix test

# Numbers Tests
cd core/foundations/numbers
mix test

# Naive Sort Tests
cd core/algorithms/naive_sort
mix test
```

---

## 📦 Requisitos / Requirements

**ES:** Elixir corre sobre **Erlang/OTP**, así que el gestor de versiones debe instalar ambos. En este entorno se usa **mise**:

**EN:** Elixir runs on **Erlang/OTP**, so the version manager must install both. This environment uses **mise**:

| Herramienta | Instalación |
|-------------|-------------|
| [mise](https://mise.jdx.dev/) (gestor de versiones) | `mise use --global elixir@1.20.4-otp-29 erlang@29.0.6` — fija las versiones en lugar de `latest` |
| Elixir + Erlang/OTP | Los instala el comando anterior y los registra en `~/.config/mise/config.toml` |
| Alternativa sin gestor | `brew install elixir` — macOS y Linux/WSL con Homebrew; instala Erlang como dependencia |

```bash
# Verificar instalación / Verify installation
elixir --version   # Elixir 1.20.4 (compiled with Erlang/OTP 29)
mix --version      # Mix 1.20.4 (compiled with Erlang/OTP 29)

# Ver qué versiones gestiona mise y desde qué archivo
mise ls
```

**Versiones verificadas en este repositorio / Versions verified in this repository:**

| Herramienta | Versión | Origen |
|-------------|---------|--------|
| Elixir | `1.20.4-otp-29` | `~/.config/mise/config.toml` |
| Erlang/OTP | `29.0.6` (`erts-17.0.6`) | `~/.config/mise/config.toml` |
| Mix | `1.20.4` | Incluido con Elixir |

### 🔧 Instalación estable / Stable setup

**ES:** Elixir se gestiona con **mise** y las versiones están **fijadas** (no `latest`), para que una actualización no desalinee Elixir con el Erlang/OTP con el que fue compilado.

**EN:** Elixir is managed with **mise** and versions are **pinned** (not `latest`), so an update cannot misalign Elixir with the Erlang/OTP it was compiled against.

```toml
# ~/.config/mise/config.toml
[tools]
elixir = "1.20.4-otp-29"
erlang = "29.0.6"
gleam = "1.18.1"
```

**ES:** El sufijo `-otp-29` de Elixir debe coincidir con la **versión mayor** de Erlang. Subir Erlang dentro de su mayor (`29.0.x`) es seguro; un salto de mayor (por ejemplo a OTP 30) obliga a actualizar también el sufijo de Elixir. Por eso las tres versiones se fijan en lugar de usar `latest`.

**EN:** Elixir's `-otp-29` suffix must match Erlang's **major version**. Bumping Erlang within its major (`29.0.x`) is safe; a major jump (e.g. to OTP 30) also requires updating Elixir's suffix. That is why all three versions are pinned instead of using `latest`.

```bash
# Comprobar que el entorno está sano / Check the environment is healthy
mise doctor     # esperado / expected: No problems found
```

**ES:** `mise doctor` no debe reportar avisos. El estado verificado de este repositorio es **sin problemas**: el backend de Erlang es `core:erlang`, el PATH de mise va primero y los shells de login cargan `~/.bashrc` desde `~/.bash_profile`.

**EN:** `mise doctor` should report no warnings. The verified state of this repository is **problem-free**: Erlang's backend is `core:erlang`, mise paths come first, and login shells load `~/.bashrc` from `~/.bash_profile`.

### 🔍 Diagnóstico / Troubleshooting

**ES:** Si `elixir --version` devuelve `command not found` (exit 127), recorre esta lista en orden:

**EN:** If `elixir --version` returns `command not found` (exit 127), walk this list in order:

1. `mise doctor` → debe indicar `activated: yes` y `shims_on_path: yes`.
2. `command -v elixir` → si no aparece en un shell de login, revisa que `~/.bash_profile` cargue `~/.bashrc`:
   ```bash
   # ~/.bash_profile
   [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
   ```
3. `echo "$PATH" | tr ':' '\n' | grep -nE 'opam|mise'` → un directorio que preceda a los de mise puede ocultar sus binarios; los de mise deben salir primero.
4. `mise ls` → confirma las versiones instaladas y el archivo de configuración de origen.

> **ES:** El propósito de `elixir --version` no es solo ver el número: es confirmar que **Erlang/OTP también** está disponible, porque Elixir no arranca sin él.
> **EN:** The point of `elixir --version` is not just the number: it confirms that **Erlang/OTP is available too**, because Elixir will not start without it.

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Script simple (archivo `.exs`)

**ES:** Un único archivo fuente `.exs`, sin dependencias externas, ejecutado directamente con `elixir`. No necesita función `main()`; el código se ejecuta de arriba a abajo. Ideal para `helloworld` y `hellouser`.

**EN:** A single `.exs` source file, no external dependencies, executed directly with `elixir`. No `main()` function needed; the code runs top-to-bottom. Ideal for `helloworld` and `hellouser`.

```bash
elixir <archivo>.exs
```

### 2. Proyecto Mix + tests (ExUnit)

**ES:** Para proyectos que requieren pruebas unitarias, se utiliza `mix.exs` como manifiesto y **ExUnit** como framework de testing. Los tests se colocan en `test/` y se ejecutan con `mix test`.

**EN:** For projects requiring unit tests, `mix.exs` is used as the manifest and **ExUnit** as the testing framework. Tests go in `test/` and are run with `mix test`.

```bash
mix test
```

---

## 🧠 Características del lenguaje / Language Features

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | BEAM (Erlang VM) — concurrencia ligera (Actors/Processes), tolerancia a fallos |
| **Paradigma** | Funcional — datos inmutables, pattern matching, guards |
| **Iteración** | Recursión con acumulador (TCO garantizado por BEAM) o `Enum`/`Stream` |
| **Sin bucles** | No hay `for`/`while` tradicionales |
| **Tests** | `ExUnit` incluido — `mix test` compila y ejecuta |
| **Scripts** | `.exs` (interpretados) vs `.ex` (compilados con Mix) |

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*