# Elixir

Proyectos en **Elixir**, ejecutados sobre la **BEAM** (Erlang VM).

Usa `mix.exs` como manifiesto de proyecto, **Mix** como herramienta de construcción y **ExUnit** como framework de pruebas unitarias (incluido en el lenguaje).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `calculator`, `numbers` |

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
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
|-------------|-------------|
| [Elixir](https://elixir-lang.org/) | `brew install elixir` (macOS) / [descargar](https://elixir-lang.org/install.html) (Linux, Windows) |

```bash
# Verificar instalación
elixir --version
mix --version
```

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