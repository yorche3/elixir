# Hello, World! — Elixir

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Elixir**, ejecutado con **elixir**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.exs`](hello_world.exs) | Código fuente (script `.exs`): imprime `"Hello, World! from Elixir!"` en la consola. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.exs    # Script Elixir (.exs)
└── README.md          # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Elixir** y sigue un enfoque minimalista: un único archivo script `.exs`, sin dependencias externas, ejecutado directamente con `elixir`.

Características:
- **Sin dependencias externas** — solo usa `IO.puts` del core de Elixir.
- **Script vs compilado** — los archivos `.exs` son scripts que se ejecutan sin compilación previa (a diferencia de `.ex` que requieren compilación con `mix`).
- **Sin archivo de proyecto** — no necesita `mix.exs`.

**EN:** This project uses **Elixir** and follows a minimalist approach: a single `.exs` script file, no external dependencies, executed directly with `elixir`.

Features:
- **No external dependencies** — only uses `IO.puts` from Elixir core.
- **Script vs compiled** — `.exs` files are scripts that run without prior compilation (unlike `.ex` files that require compilation with `mix`).
- **No project file** — no `mix.exs` needed.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hello_world.exs`

**ES:** Punto de entrada. Llama a `IO.puts` para imprimir el saludo en la salida estándar.

**EN:** Entry point. Calls `IO.puts` to print the greeting to standard output.

```elixir
IO.puts "Hello, World! from Elixir!"
```

| Elemento | Propósito |
|----------|-----------|
| `IO.puts` | Módulo/función de Elixir que imprime una cadena seguida de un salto de línea |
| `"Hello, World! from Elixir!"` | Cadena literal que se muestra en la salida estándar |
| Sin `main()` | Los scripts `.exs` se ejecutan de arriba a abajo, no necesitan función `main` |

> **ES:** `IO.puts` es la función estándar de salida de Elixir, definida en el módulo `IO`. Acepta cadenas (binarios) y otros tipos imprimibles, y añade un salto de línea al final.
> **EN:** `IO.puts` is Elixir's standard output function, defined in the `IO` module. It accepts strings (binaries) and other printable types, and adds a newline at the end.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Elixir instalado

```bash
# Linux / macOS (con Homebrew)
brew install elixir

# Windows
# Descargar desde: https://elixir-lang.org/install.html
```

### Ejecutar

```bash
cd core/foundations/helloworld
elixir hello_world.exs
```

**Salida esperada / Expected output:**

```text
Hello, World! from Elixir!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Los archivos `.exs` son scripts de Elixir (ejecutables con `elixir`), mientras que `.ex` son archivos compilados (usados con `mix`).
- **EN:** `.exs` files are Elixir scripts (run with `elixir`), while `.ex` files are compiled files (used with `mix`).
- **ES:** Elixir se ejecuta sobre la máquina virtual de Erlang (BEAM). El comando `elixir` es un wrapper que arranca el runtime de Erlang con el código Elixir.
- **EN:** Elixir runs on the Erlang VM (BEAM). The `elixir` command is a wrapper that starts the Erlang runtime with Elixir code.
- **ES:** No se necesita `mix.exs` para scripts simples; solo se requiere cuando se usan dependencias externas o se compila un proyecto.
- **EN:** No `mix.exs` file is needed for simple scripts; it's only required when using external dependencies or compiling a project.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
