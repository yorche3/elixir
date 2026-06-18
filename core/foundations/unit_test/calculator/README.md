# Calculator — Elixir

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Elixir**, ejecutado con **mix test**.

Implementa 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`mix.exs`](mix.exs) | Manifiesto del proyecto Elixir (Mix). |
| [`lib/calculator.ex`](lib/calculator.ex) | Implementación de las 5 operaciones aritméticas. |
| [`test/calculator_test.exs`](test/calculator_test.exs) | 5 tests con `ExUnit`. |
| [`test/test_helper.exs`](test/test_helper.exs) | Arranque de `ExUnit`. |

**Estructura de directorios esperada:**

```text
calculator/
├── mix.exs                       # Manifiesto del proyecto
├── lib/
│   └── calculator.ex             # 5 operaciones aritméticas
├── test/
│   ├── test_helper.exs           # Arranque de ExUnit
│   └── calculator_test.exs       # 5 tests
└── README.md                     # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Elixir** con **Mix** para construir y **ExUnit** como framework de tests.

Características:
- **5 operaciones**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Implementación minimalista**: `multiplication`, `division` y `modulus` se construyen usando solo `+` y `-` como operaciones primitivas.
- **Recursión con pattern matching**: `multiplication` y `division` usan pattern matching en sus helpers para el caso base y la recursión.
- **Framework de tests**: `ExUnit` — el framework de testing incluido en Elixir.

**EN:** This project uses **Elixir** with **Mix** for building and **ExUnit** as the test framework.

Features:
- **5 operations**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Minimalist implementation**: `multiplication`, `division` and `modulus` are built using only `+` and `-` as primitive operations.
- **Recursion with pattern matching**: `multiplication` and `division` use pattern matching in their helpers for base case and recursion.
- **Test framework**: `ExUnit` — Elixir's built-in testing framework.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `mix.exs` — Manifiesto del proyecto

**ES:** Define el nombre de la aplicación, versión y versión de Elixir requerida.

**EN:** Defines the application name, version and required Elixir version.

```elixir
defmodule Calculator.MixProject do
  use Mix.Project

  def project do
    [
      app: :calculator,
      version: "0.1.0",
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end
end
```

### `lib/calculator.ex` — Implementación

**ES:** Las 5 operaciones como funciones del módulo `Calculator`. `multiplication` y `division` usan pattern matching con guards para implementar la recursión con acumulador.

**EN:** The 5 operations as functions of the `Calculator` module. `multiplication` and `division` use pattern matching with guards to implement recursive accumulation.

```elixir
defmodule Calculator do
  def addition(a, b), do: a + b
  def subtraction(a, b), do: a - b

  def multiplication(a, b) do
    _multiplication_loop(a, b, a)
  end

  defp _multiplication_loop(_, b, product) when b == 1, do: product
  defp _multiplication_loop(a, b, product) do
    _multiplication_loop(a, subtraction(b, 1), addition(product, a))
  end

  def division(a, b) do
    _division_loop(a, b, 0)
  end

  defp _division_loop(a, b, quotient) when a < b or b == 0, do: quotient
  defp _division_loop(a, b, quotient) do
    _division_loop(subtraction(a, b), b, addition(quotient, 1))
  end

  def modulus(a, b) do
    quotient = division(a, b)
    subtraction(a, multiplication(b, quotient))
  end
end
```

### `test/calculator_test.exs` — Pruebas

**ES:** 5 tests con `ExUnit`, cada uno usando `assert`.

**EN:** 5 tests with `ExUnit`, each using `assert`.

```elixir
defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "Multiplication Test" do
    assert Calculator.multiplication(4, 3) == 12
  end

  test "Division Test" do
    assert Calculator.division(10, 3) == 3
  end

  # ...
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
cd core/foundations/unit_test/calculator
mix test
```

**Salida esperada / Expected output:**

```text
......

Finished in 0.03 seconds (0.00s async, 0.03s sync)
5 tests, 0 failures
```

---

## 🧠 Algoritmos / operaciones

| Operación | Implementación | Primitivas usadas |
|-----------|---------------|-------------------|
| `addition(a, b)` | `a + b` | `+` |
| `subtraction(a, b)` | `a - b` | `-` |
| `multiplication(a, b)` | Suma repetitiva de `a`, `b - 1` veces | `+`, `-` |
| `division(a, b)` | Resta repetitiva, cuenta cociente | `+`, `-` |
| `modulus(a, b)` | `a - (cociente * b)` | `+`, `-` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El pattern matching con guards (`when`) es una característica central de Elixir que permite definir múltiples cláusulas para una función.
- **EN:** Pattern matching with guards (`when`) is a core Elixir feature that allows defining multiple clauses for a function.
- **ES:** Las funciones privadas (`defp`) se usan para los helpers internos de `multiplication` y `division`.
- **EN:** Private functions (`defp`) are used for the internal helpers of `multiplication` and `division`.
- **ES:** `mix test` compila el proyecto y ejecuta todos los tests automáticamente.
- **EN:** `mix test` compiles the project and runs all tests automatically.
- **ES:** No se requieren dependencias externas para hacer tests; `ExUnit` viene incluido con Elixir.
- **EN:** No external dependencies are required for testing; `ExUnit` comes bundled with Elixir.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

