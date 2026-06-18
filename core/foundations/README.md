# 🚀 Foundations — Elixir

Implementaciones de la [Fase 0 — Fundamentos](https://yorche3.github.io/programming_languages/ROADMAP/#fase-0--fundamentos--foundations--completada) en **Elixir**: `helloworld`, `hellouser`, `unit_test/calculator` y `numbers`.

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`helloworld/`](helloworld/) | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | `elixir` (script `.exs`) | — | ✅ |
| [`hellouser/`](hellouser/) | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | `elixir` (script `.exs`) | — | ✅ |
| [`unit_test/calculator/`](unit_test/calculator/) | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | `mix test` + `ExUnit` | 5 | ✅ |
| [`numbers/`](numbers/) | [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | `mix test` + `ExUnit` | 10 | ✅ |

---

## 📁 Estructura / Structure

```text
foundations/
├── helloworld/                   # 01_Hello_World
│   ├── hello_world.exs           # IO.puts "Hello, World! from Elixir!"
│   └── README.md
│
├── hellouser/                    # 02_Hello_User
│   ├── hello_user.exs            # IO.gets + <> (concatenación)
│   └── README.md
│
├── unit_test/
│   └── calculator/               # 03_Unit_Test_Calculator
│       ├── mix.exs
│       ├── lib/
│       │   └── calculator.ex     # 5 operaciones (pattern matching + guards)
│       ├── test/
│       │   ├── test_helper.exs
│       │   └── calculator_test.exs  # 5 tests
│       └── README.md
│
└── numbers/                      # 04_Numbers
    ├── mix.exs
    ├── lib/
    │   └── numbers.ex            # 15 funciones (2 enfoques × 5 algoritmos)
    ├── test/
    │   ├── test_helper.exs
    │   ├── numbers_rec_test.exs  # 5 tests recursivos directos
    │   └── numbers_acc_test.exs  # 5 tests con acumulador
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | BEAM (Erlang VM) — ejecución concurrente y tolerante a fallos |
| **CLI** | `elixir` para scripts `.exs`; `mix` para proyectos con tests |
| **Scripts simples** | `elixir <archivo>.exs` — sin compilación previa, sin `mix.exs` |
| **Proyectos con tests** | `mix test` — compila y ejecuta tests con `ExUnit` |
| **Manifiesto** | `mix.exs` — define aplicación, versión y dependencias |
| **Framework de tests** | `ExUnit` — integrado en Elixir, sin dependencias externas |
| **Pattern matching** | Múltiples cláusulas de función con guards (`when`) para casos base |
| **Recursión** | Forma principal de iteración; la BEAM garantiza TCO |
| **Sin bucles tradicionales** | No hay `for`/`while` estilo imperativo; se usa recursión o `Enum` |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Hello, World!
cd helloworld
elixir hello_world.exs

# Hello, User!
cd hellouser
elixir hello_user.exs

# Calculator Tests
cd unit_test/calculator
mix test

# Numbers Tests
cd numbers
mix test
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Después de fundamentos, continúa con [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).  
👉 After foundations, continue with [Phase 1 — Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).

---

*[← Volver a Elixir](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
