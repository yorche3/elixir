# 🚀 Algorithms Pure — Elixir

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Elixir**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase usan **indicadores de fallo compatibles con el lenguaje** (`nil` retornado como valor) en lugar de excepciones.

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `mix test` + `ExUnit` | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                   # 05_Naive_Sort
    ├── mix.exs
    ├── lib/
    │   └── naive_sort.ex         # selection_sort, bubble_sort, insertion_sort
    ├── test/
    │   ├── test_helper.exs
    │   └── naive_sort_test.exs   # 3 tests (8 casos cada uno)
    ├── .formatter.exs
    ├── .gitignore
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | BEAM (Erlang VM) — ejecución concurrente y tolerante a fallos |
| **CLI** | `mix` para proyectos con `mix.exs`; `elixir` para scripts `.exs` |
| **Proyectos con tests** | `mix test` — compila y ejecuta los tests con `ExUnit` |
| **Manifiesto** | `mix.exs` — define aplicación, versión y dependencias |
| **Framework de tests** | `ExUnit` — integrado en Elixir, sin dependencias externas |
| **Raíz del código** | `lib/` (convención de Mix), no `src/` |
| **Formato** | `mix format` con `.formatter.exs` |
| **Pattern matching** | Cláusulas y guards (`when`) resuelven los casos base |
| **Iteración** | Recursión; la BEAM garantiza TCO |
| **Indicador de fallo** | `nil` retornado como valor, sin excepciones |
| **Ordenamiento** | Devuelve una lista nueva — las listas son inmutables |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
mix test
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
