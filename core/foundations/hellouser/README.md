# Hello, User! — Elixir

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Elixir**, ejecutado con **elixir**.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.exs`](hello_user.exs) | Código fuente (script `.exs`): solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hello_user.exs     # Script Elixir (.exs)
└── README.md          # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce dos conceptos nuevos respecto a `hello_world`:

1. **Lectura de entrada** — `IO.gets` lee una línea completa desde `stdin`.
2. **Concatenación de cadenas** — `<>` es el operador de concatenación de strings en Elixir.

**EN:** This program introduces two new concepts compared to `hello_world`:

1. **Input reading** — `IO.gets` reads a full line from `stdin`.
2. **String concatenation** — `<>` is Elixir's string concatenation operator.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hello_user.exs`

**ES:** El flujo del programa es:

1. Solicitar el nombre con `IO.gets "Enter your name: "`.
2. Concatenar el resultado con `<>` en el saludo.
3. Imprimir el saludo con `IO.puts`.

**EN:** Program flow:

1. Prompt for the name with `IO.gets "Enter your name: "`.
2. Concatenate the result with `<>` in the greeting.
3. Print the greeting with `IO.puts`.

```elixir
name = IO.gets "Enter your name: "
IO.puts "Hello " <> name <> "!"
```

| Elemento | Propósito |
|----------|-----------|
| `IO.gets/1` | Lee una línea desde `stdin`. El argumento es un prompt opcional que se imprime antes de leer |
| `name` | Variable (inmutable por defecto en Elixir) que almacena el nombre ingresado |
| `<>` | Operador de concatenación de strings (binarios) en Elixir |
| `IO.puts/1` | Imprime el saludo con salto de línea al final |

> **ES:** `IO.gets/1` retorna una cadena que **incluye** el salto de línea (`\n`) al final. Cuando se concatena con `Hello ` y `!`, el resultado imprime el nombre seguido del `\n` y luego `!` en la siguiente línea.
> **EN:** `IO.gets/1` returns a string that **includes** the trailing newline (`\n`). When concatenated with `Hello ` and `!`, the result prints the name followed by `\n` and then `!` on the next line.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Elixir instalado

```bash
brew install elixir     # macOS / Linux
```

### Ejecutar

```bash
cd core/foundations/hellouser
elixir hello_user.exs
```

**Salida esperada / Expected output:**

```text
Enter your name: Ada
Hello Ada
!
```

> **Nota:** El signo de exclamación aparece en la línea siguiente porque `IO.gets` incluye el `\n` al final del nombre ingresado.
> **Note:** The exclamation mark appears on the next line because `IO.gets` includes the trailing `\n` in the input.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `IO.gets/1` incluye el salto de línea en el resultado. Para eliminarlo se usa `String.trim/1`.
- **EN:** `IO.gets/1` includes the trailing newline in the result. To remove it, use `String.trim/1`.
- **ES:** Las variables en Elixir son **inmutables** y se asignan por reasignación (rebinding), no por mutación.
- **EN:** Variables in Elixir are **immutable** and are assigned by rebinding, not by mutation.
- **ES:** El operador `<>` solo funciona con cadenas (binarios). Para otros tipos hay que convertirlos explícitamente.
- **EN:** The `<>` operator only works with strings (binaries). Other types need explicit conversion.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
