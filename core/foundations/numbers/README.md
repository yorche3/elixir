# Numbers — Elixir

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Elixir**, ejecutado con **mix test**.

Implementa 5 algoritmos fundamentales (suma de los primeros N naturales, factorial, Fibonacci, MCD, MCM) utilizando dos enfoques: **recursivo directo** y **recursivo con acumulador**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`mix.exs`](mix.exs) | Manifiesto del proyecto Elixir (Mix). |
| [`lib/numbers.ex`](lib/numbers.ex) | 15 funciones (3 enfoques × 5 algoritmos). |
| [`test/numbers_rec_test.exs`](test/numbers_rec_test.exs) | 5 tests para el enfoque recursivo directo. |
| [`test/numbers_acc_test.exs`](test/numbers_acc_test.exs) | 5 tests para el enfoque con acumulador. |
| [`test/test_helper.exs`](test/test_helper.exs) | Arranque de `ExUnit`. |

**Estructura de directorios esperada:**

```text
numbers/
├── mix.exs                       # Manifiesto del proyecto
├── lib/
│   └── numbers.ex                # 15 funciones (3 enfoques × 5 algoritmos)
├── test/
│   ├── test_helper.exs           # Arranque de ExUnit
│   ├── numbers_rec_test.exs      # 5 tests recursivos directos
│   └── numbers_acc_test.exs      # 5 tests con acumulador
└── README.md                     # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Elixir** con **Mix** para construir y **ExUnit** como framework de tests.

Cada algoritmo se implementa de tres formas distintas, aunque dos de ellas coinciden semánticamente:

1. **Recursivo Directo (`..._rec`)**: Basado en la definición matemática, con pattern matching y guards para los casos base.
2. **Recursivo con Acumulador (`..._acc`)**: Expone una función limpia que delega en un helper privado (`_help`) con tail recursion.

**No hay versión iterativa explícita** — en Elixir la forma idiomática de "iterar" es mediante recursión con acumulador (tail recursion). El lenguaje no tiene construcciones de bucle tradicionales como `for`/`while`; en su lugar se usan funciones recursivas (que la BEAM optimiza como TCO) o enumerables con `Enum`/`Stream`. La versión con acumulador es, en la práctica, la versión iterativa de Elixir.

**EN:** This project uses **Elixir** with **Mix** for building and **ExUnit** as the test framework.

Each algorithm is implemented in two different ways:

1. **Direct Recursive (`..._rec`)**: Based on the mathematical definition, with pattern matching and guards for base cases.
2. **Accumulator Recursive (`..._acc`)**: Exposes a clean function that delegates to a private helper (`_help`) with tail recursion.

**There is no explicit iterative version** — in Elixir the idiomatic way to "iterate" is through recursion with accumulators (tail recursion). The language has no traditional loop constructs like `for`/`while`; instead, recursive functions (which the BEAM optimizes as TCO) or enumerables with `Enum`/`Stream` are used. The accumulator version is, in practice, Elixir's iterative version.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `mix.exs` — Manifiesto del proyecto

**ES:** Define el nombre de la aplicación, versión y versión de Elixir requerida.

**EN:** Defines the application name, version and required Elixir version.

```elixir
defmodule Numbers.MixProject do
  use Mix.Project

  def project do
    [
      app: :numbers,
      version: "0.1.0",
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end
end
```

### `lib/numbers.ex` — Implementación

**ES:** Las 15 funciones usando pattern matching (múltiples cláusulas con guards y valores literales). Los helpers con acumulador usan tail recursion, que la BEAM optimiza como TCO.

**EN:** The 15 functions using pattern matching (multiple clauses with guards and literal values). Accumulator helpers use tail recursion, which the BEAM optimizes as TCO.

```elixir
defmodule Numbers do
  # Recursivo directo — pattern matching con guards
  def fibonacci_rec(n) when n <= 0, do: 0
  def fibonacci_rec(1), do: 1
  def fibonacci_rec(n), do: fibonacci_rec(n - 1) + fibonacci_rec(n - 2)

  # Helper con acumulador — tail recursion (TCO en BEAM)
  def fibonacci_acc(n), do: _fibonacci_help(n, 0, 1)
  def _fibonacci_help(n, acc1, _) when n <= 0, do: acc1
  def _fibonacci_help(n, acc1, acc2), do: _fibonacci_help(n - 1, acc2, acc1 + acc2)

  # Pattern matching directo en argumentos
  def largest_common_divisor_rec(a, 0), do: a
  def largest_common_divisor_rec(a, b), do: largest_common_divisor_rec(b, rem(a, b))
end
```

### `test/numbers_rec_test.exs` — Pruebas recursivas

**ES:** 5 tests con `ExUnit`, cada uno usando `assert`.

**EN:** 5 tests with `ExUnit`, each using `assert`.

```elixir
defmodule NumbersRecTest do
  use ExUnit.Case

  test "Fibonacci Recursive" do
    assert Numbers.fibonacci_rec(0) == 0
    assert Numbers.fibonacci_rec(1) == 1
    assert Numbers.fibonacci_rec(6) == 8
  end
end
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Elixir instalado

```bash
brew install elixir     # macOS / Linux
```

### Ejecutar pruebas

```bash
cd core/foundations/numbers
mix test
```

**Salida esperada / Expected output:**

```text
..........

Finished in 0.03 seconds (0.00s async, 0.03s sync)
10 tests, 0 failures
```

---

## 🧠 Algoritmos / operaciones

### 2 enfoques × 5 algoritmos = 10 funciones / 10 tests

| Algoritmo | Casos de prueba | `_rec` | `_acc` |
|-----------|----------------|:------:|:------:|
| `sum_first_n` | `(0) = 0`, `(3) = 6` | ✅ | ✅ |
| `factorial` | `(0) = 1`, `(4) = 24` | ✅ | ✅ |
| `fibonacci` | `(0) = 0`, `(1) = 1`, `(6) = 8` | ✅ | ✅ |
| `largest_common_divisor` | `(12, 8) = 4`, `(7, 5) = 1` | ✅ | ✅ |
| `least_common_multiple` | `(8, 6) = 24`, `(6, 4) = 12` | ✅ | ✅ |

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Sobre la ausencia de versión iterativa explícita / On the absence of an explicit iterative version

**ES:**

A diferencia de otros lenguajes en este repositorio, **Elixir no tiene versiones `_iter` (iterativas)**. La razón es que Elixir no proporciona construcciones de bucle tradicionales (`for`, `while`, `loop`). En su lugar:

- **La recursión con acumulador es el equivalente iterativo de Elixir.** La BEAM (máquina virtual de Erlang) garantiza Tail Call Optimization (TCO), por lo que las llamadas recursivas finales no consumen pila y se ejecutan con la misma eficiencia que un bucle.
- Las funciones `fibonacci_rec(10000)` romperían la pila por la doble recursión; pero `fibonacci_acc(10000)` se ejecuta sin problemas porque es tail recursion optimizada.
- Para operaciones sobre colecciones, Elixir proporciona `Enum.map`, `Enum.reduce`, etc., que internamente usan recursión.

Por lo tanto, la versión con acumulador (`..._acc`) cumple el rol de la versión iterativa en Elixir. Ambas versiones tienen tests unitarios separados (10 tests en total).

**EN:**

Unlike other languages in this repository, **Elixir has no explicit `_iter` (iterative) versions**. The reason is that Elixir does not provide traditional loop constructs (`for`, `while`, `loop`). Instead:

- **Recursion with accumulators is Elixir's iterative equivalent.** The BEAM (Erlang VM) guarantees Tail Call Optimization (TCO), so final recursive calls don't consume stack and run with the same efficiency as a loop.
- `fibonacci_rec(10000)` would blow the stack due to double recursion; but `fibonacci_acc(10000)` runs fine because it's tail-recursion optimized.
- For collection operations, Elixir provides `Enum.map`, `Enum.reduce`, etc., which internally use recursion.

Thus, the accumulator version (`..._acc`) fulfills the role of the iterative version in Elixir. Both versions have separate unit tests (10 tests total).

### Sobre la implementación / On the implementation

- **ES:** El pattern matching es central en Elixir. `def fibonacci_rec(1), do: 1` es una cláusula que solo coincide cuando `n == 1`.
- **EN:** Pattern matching is central in Elixir. `def fibonacci_rec(1), do: 1` is a clause that only matches when `n == 1`.
- **ES:** Las guards (`when n <= 0`) permiten definir casos base en los parámetros de la función.
- **EN:** Guards (`when n <= 0`) allow defining base cases in the function parameters.
- **ES:** Las funciones privadas (`defp`) se usan para helpers internos que no deben ser llamados directamente.
- **EN:** Private functions (`defp`) are used for internal helpers that shouldn't be called directly.
- **ES:** `mix test` compila el proyecto y ejecuta todos los tests automáticamente.
- **EN:** `mix test` compiles the project and runs all tests automatically.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

