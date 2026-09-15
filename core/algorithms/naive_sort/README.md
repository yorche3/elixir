# Naive Sort — Elixir

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Elixir**, ejecutado con **mix test**.

Implementa los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — con recursión y pattern matching, sin invocar bibliotecas de ordenamiento del sistema.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`mix.exs`](mix.exs) | Manifiesto del proyecto Elixir (Mix). |
| [`lib/naive_sort.ex`](lib/naive_sort.ex) | 3 funciones públicas + 3 helpers privados. |
| [`test/naive_sort_test.exs`](test/naive_sort_test.exs) | 3 tests (8 casos cada uno). |
| [`test/test_helper.exs`](test/test_helper.exs) | Arranque de `ExUnit`. |
| [`.formatter.exs`](.formatter.exs) | Configuración de `mix format`. |
| `.gitignore` | `_build/`, `deps/`, `cover/` y artefactos de Mix. |

**Estructura de directorios / Directory layout:**

```text
naive_sort/
├── mix.exs                       # Manifiesto del proyecto
├── lib/
│   └── naive_sort.ex             # 3 funciones públicas + 3 helpers privados
├── test/
│   ├── test_helper.exs           # Arranque de ExUnit
│   └── naive_sort_test.exs       # 3 tests (8 casos cada uno)
├── .formatter.exs
├── .gitignore
└── README.md                     # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con `mix new naive_sort`. Elixir no tiene bucles imperativos, así que los tres algoritmos se expresan con **recursión y pattern matching**, y cada función devuelve una lista ordenada nueva en lugar de mutar la lista recibida.

**EN:** The project was created with `mix new naive_sort`. Elixir has no imperative loops, so all three algorithms are expressed with **recursion and pattern matching**, and each function returns a new sorted list instead of mutating the received list.

```bash
mix new naive_sort
```

---

## 📄 Configuración clave / Key Configuration

### `mix.exs` — Manifiesto del proyecto

**ES:** Define la aplicación, la versión de Elixir requerida y las dependencias. No hay dependencias externas: todo se apoya en la biblioteca estándar.

**EN:** Defines the application, the required Elixir version and dependencies. There are no external dependencies: everything relies on the standard library.

```elixir
defmodule NaiveSort.MixProject do
  use Mix.Project

  def project do
    [
      app: :naive_sort,
      version: "0.1.0",
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end
end
```

### `lib/naive_sort.ex` — Implementación

**ES:** Los casos base se resuelven con cláusulas y guards en lugar de un `if n <= 1`. Las listas de Elixir son inmutables, por lo que el `swap` del pseudocódigo se sustituye por construir una lista nueva. Los helpers (`pick_min`, `bubble_pass`, `insert`) son `defp`: no forman parte de la API del módulo.

**EN:** Base cases are resolved with clauses and guards instead of an `if n <= 1`. Elixir lists are immutable, so the pseudocode's `swap` is replaced by building a new list. The helpers (`pick_min`, `bubble_pass`, `insert`) are `defp`: they are not part of the module API.

```elixir
defmodule NaiveSort do
  def selection_sort(nil), do: nil
  def selection_sort([]), do: []
  def selection_sort([a]), do: [a]

  def selection_sort(list) do
    {min, rest} = pick_min(list)
    [min | selection_sort(rest)]
  end

  def bubble_sort(list) do
    case bubble_pass(list) do
      {false, sorted} -> sorted
      {true, partially_sorted} -> bubble_sort(partially_sorted)
    end
  end

  def insertion_sort([head | tail]) do
    insert(head, insertion_sort(tail))
  end
end
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: tener Elixir instalado

```bash
mise use --global elixir@1.20.4-otp-29 erlang@29.0.6   # gestor de versiones usado aquí
```

### Ejecutar pruebas

```bash
cd core/algorithms/naive_sort
mix compile --force
mix test
```

**Salida real de `mix compile --force` / Actual output:**

```text
Compiling 1 file (.ex)
Generated naive_sort app
```

**Salida real de `mix test` / Actual output:**

```text
Running ExUnit with seed: 852739, max_cases: 32

...
Finished in 0.01 seconds (0.00s async, 0.01s sync)

Result: 3 passed
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función | Estrategia | Complejidad | Tests |
|---------|-----------|-------------|:-----:|
| `selection_sort/1` | Extrae el mínimo (`pick_min/1`) y lo antepone al resultado de ordenar el resto | $O(n^2)$ siempre | 1 / 8 casos |
| `bubble_sort/1` | Repite `bubble_pass/1` y se detiene cuando una pasada no intercambia nada | $O(n^2)$ peor/promedio, $O(n)$ mejor | 1 / 8 casos |
| `insertion_sort/1` | Ordena la cola y luego inserta la cabeza en su posición (`insert/2`) | $O(n^2)$ peor/promedio, $O(n)$ mejor | 1 / 8 casos |

**Casos cubiertos / Covered cases:** array desordenado, ya ordenado, orden inverso, elementos idénticos, con negativos, un solo elemento, array vacío y entrada `nil`.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Divergencias idiomáticas respecto al pseudocódigo / Idiomatic divergences from the pseudocode

| Pseudocódigo | Elixir | Motivo / Reason |
|--------------|--------|-----------------|
| `swap(arr, i, min_idx)` *in-place* | Se construye una lista nueva | Las listas de Elixir son inmutables / Elixir lists are immutable |
| Bucles `for` / `while` | Recursión con cláusulas y guards | Elixir no tiene bucles imperativos / Elixir has no imperative loops |
| `swapped = false` mutado durante la pasada | `bubble_pass/1` devuelve `{swapped, lista}` | Equivalente funcional de la bandera; conserva la salida temprana / Functional equivalent of the flag; keeps the early exit |
| `if n <= 1` | Cláusulas `nil`, `[]` y `[a]` | Pattern matching idiomático / Idiomatic pattern matching |
| `if min_idx != i` (evita el swap) | El patrón `nil`/`[]`/`[a]` corta antes de construir la lista | El guardado es implícito: la recursión no baja a listas de tamaño ≤ 1 / The saving is implicit: recursion never descends into lists of size ≤ 1 |

### 🚫 Caso nulo / Null case

**ES:** Elixir sí puede representar una entrada nula: `nil`. Las tres funciones declaran `def f(nil), do: nil`, de modo que el indicador de fallo se **retorna como valor** y no se lanza ninguna excepción. Es el octavo caso de cada suite: `assert sort_function.(nil) == nil`.

**EN:** Elixir can represent a null input: `nil`. All three functions declare `def f(nil), do: nil`, so the failure indicator is **returned as a value** and no exception is raised. This is the eighth case of each suite: `assert sort_function.(nil) == nil`.

### 📁 Desviación de ubicación / Location deviation

**ES:** La especificación espera `src/naive_sort.ext` y un `run_tests.ext`. Elixir usa `lib/` como raíz del código (convención de Mix) y ExUnit incorpora su propio runner a través de `mix test`, por lo que no hace falta un archivo de ejecución aparte. El nombre del archivo de pruebas sí coincide con el esperado. Las constantes de los casos se declaran como atributos de módulo (`@standard_input`, `@reverse_output`, …) y un único helper `assert_sorts_all_cases/2` recorre los ocho casos para las tres funciones.

**EN:** The specification expects `src/naive_sort.ext` and a `run_tests.ext`. Elixir uses `lib/` as the source root (Mix convention) and ExUnit ships its own runner through `mix test`, so no separate execution file is needed. The test file name does match the expected one. Case constants are declared as module attributes (`@standard_input`, `@reverse_output`, …) and a single `assert_sorts_all_cases/2` helper walks the eight cases for all three functions.

---

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algorithms Pure](README.md) | [↑ Volver a Elixir](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

