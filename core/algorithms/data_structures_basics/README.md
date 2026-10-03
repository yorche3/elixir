# Data Structures Basics — Elixir

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics) en **Elixir**, con un enfoque manual y minimalista.

**ES:** Un único `Cell` compartido y tres estructuras enlazadas (`LinkedList`, `Stack`, `Queue`) construidas a mano sobre structs inmutables, sin usar listas ni `:queue` de la biblioteca estándar. Se ejecuta con `mix test` (ExUnit) y el verificador es `mix format --check-formatted`.

**EN:** A single shared `Cell` and three hand-built linked structures (`LinkedList`, `Stack`, `Queue`) built from immutable structs, without using the standard library's lists or `:queue`. Run with `mix test` (ExUnit); the verifier is `mix format --check-formatted`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`lib/data_structures_basics.ex`](lib/data_structures_basics.ex) | `DataStructuresBasics` con los cuatro tipos anidados (`Cell`, `LinkedList`, `Stack`, `Queue`) / `DataStructuresBasics` with the four nested types |
| [`test/data_structures_basics_test.exs`](test/data_structures_basics_test.exs) | Suite de ExUnit: 4 tests (uno por estructura), 15 casos / ExUnit suite: 4 tests (one per structure), 15 cases |
| [`test/test_helper.exs`](test/test_helper.exs) | Arranque de `ExUnit` / `ExUnit` boot |
| [`mix.exs`](mix.exs) | Manifiesto del proyecto (Mix) / Mix project manifest |
| [`.formatter.exs`](.formatter.exs) | Configuración de `mix format` / `mix format` configuration |
| `.gitignore` | Excluye `_build/`, `deps/` y artefactos de Mix / Ignores generated files |

**Estructura de directorios / Directory layout:**

```text
data_structures_basics/
├── mix.exs                        # Manifiesto del proyecto
├── lib/
│   └── data_structures_basics.ex  # DataStructuresBasics + Cell, LinkedList, Stack, Queue
├── test/
│   ├── test_helper.exs            # Arranque de ExUnit
│   └── data_structures_basics_test.exs  # 4 tests (15 casos)
├── .formatter.exs
├── .gitignore
└── README.md                      # Este archivo
```

**Nota de desviación / Deviation note:**

**ES:** la especificación espera `src/data_structures_basics.ext` y `test/run_tests.ext`; aquí el código vive en `lib/data_structures_basics.ex` y la suite en `test/`, la convención de proyecto de Mix (`mix new`). **No hay `run_tests`**: `mix test` es el runner y descubre `test/**/*_test.exs` por convención.

**EN:** the specification expects `src/data_structures_basics.ext` and `test/run_tests.ext`; here the code lives in `lib/data_structures_basics.ex` and the suite in `test/`, the Mix project convention (`mix new`). There is **no `run_tests`**: `mix test` is the runner and discovers `test/**/*_test.exs` by convention.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con la plantilla de Mix y se completó a mano. Elixir no tiene mutación: cada operación devuelve una estructura nueva, así que el `head`/`tail`/`top`/`front`/`rear` del pseudocódigo se actualiza **construyendo** structs nuevos, no asignando campos.

**EN:** The project was created with the Mix template and completed by hand. Elixir has no mutation: every operation returns a new structure, so the pseudocode's `head`/`tail`/`top`/`front`/`rear` is updated by **building** new structs, not by assigning fields.

```bash
mix new data_structures_basics
```

---

## 📄 Configuración clave / Key Configuration

- `mix.exs`: aplicación `:data_structures_basics`, Elixir `~> 1.20`, `extra_applications: [:logger]` y **sin dependencias externas** (`deps` vacío: todo se apoya en la biblioteca estándar) / app `:data_structures_basics`, Elixir `~> 1.20`, `extra_applications: [:logger]` and **no external dependencies**.
- `.formatter.exs`: entradas por defecto del proyecto; `mix format` es el verificador de estilo / default project inputs; `mix format` is the style verifier.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
mix compile --force
mix format --check-formatted
mix test
```

**Salida real / Actual output:**

```text
$ mix compile --force
Compiling 1 file (.ex)
Generated data_structures_basics app

$ mix format --check-formatted
(sin salida / no output; código de salida / exit code 0)

$ mix test
Running ExUnit with seed: 716509, max_cases: 32

....
Finished in 0.04 seconds (0.00s async, 0.04s sync)

Result: 4 passed
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Cell.new/1`, `value/1`, `next/1`, `put_next/2` | `integer → t`, `t → integer / t / t` | `O(1)` | `next/1` es `nil` si no hay enlace / `nil` when absent; `put_next/2` devuelve una celda nueva / returns a new cell |
| `LinkedList.new/0`, `empty?/1`, `size/1`, `head_value/1` | `t → t / boolean / non_neg_integer / integer` | `O(1)` | `head_value/1` → `-1` si la lista está vacía / if empty |
| `LinkedList.insert_head/2` | `t, integer → t` | `O(1)` | Antepone una celda / prepends a cell |
| `LinkedList.insert_tail/2` | `t, integer → t` | **`O(n)`** | Reconstruye el tramo hasta la cola / rebuilds the path to the tail |
| `LinkedList.delete/2` | `t, integer → {boolean, t}` | `O(n)` | Elimina la primera aparición / removes the first occurrence |
| `Stack.new/0`, `empty?/1`, `size/1`, `peek/1`, `pop/1` | `t → t / boolean / non_neg_integer / integer / {integer, t}` | `O(1)` | LIFO sobre `top` / LIFO over `top` |
| `Stack.push/2` | `t, integer → t` | `O(1)` | Apila una celda nueva / pushes a new cell |
| `Queue.new/0`, `empty?/1`, `size/1`, `peek/1`, `dequeue/1` | `t → t / boolean / non_neg_integer / integer / {integer, t}` | `O(1)` | FIFO sobre `front` / FIFO over `front` |
| `Queue.enqueue/2` | `t, integer → t` | **`O(n)`** | Reconstruye el tramo hasta la cola / rebuilds the path to the tail |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Cuatro structs **anidados** en `DataStructuresBasics` | Cuatro módulos sueltos (`Cell`, `Stack`…) | Agrupa los tipos del módulo bajo el espacio de nombres del proyecto y evita nombres genéricos (`Cell`) en la imagen global / groups the module's types under the project namespace and avoids generic global names |
| Celdas inmutables: `put_next/2` devuelve una celda nueva | Celdas mutables | Elixir no permite mutar un struct; el enlace se devuelve nuevo / Elixir cannot mutate a struct; the link is returned new |
| `delete/2`, `pop/1` y `dequeue/1` devuelven `{resultado, t}` | Devolver solo el resultado | Al no mutar, el llamador necesita la estructura nueva junto al valor / without mutation the caller needs the new structure |
| Indicador de fallo `-1` | `nil` | Mantiene el retorno `integer` en toda operación de valor y no colisiona con los enteros positivos de prueba / keeps an `integer` return and does not clash with positive test values |
| Una prueba por estructura | Una prueba por caso | Los casos de la especificación son pasos sucesivos sobre la misma instancia, y Elixir no la muta / the spec's cases are successive steps on one instance, and Elixir does not mutate it |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node.init(value)` y `init()` tras declarar | Constructores `Cell.new/1`, `LinkedList.new/0`, `Stack.new/0`, `Queue.new/0` | Elixir no tiene instancias sin construir; el constructor es el `init` y deja el mismo estado inicial / Elixir has no unbuilt instances; the constructor is the idiomatic `init` |
| `get_value()`, `get_next()`, `set_next()` | `Cell.value/1`, `Cell.next/1`, `Cell.put_next/2` | Con structs inmutables, enlazar **devuelve una celda nueva** en lugar de mutar la existente / linking returns a new cell instead of mutating |
| Ausencia de enlace | `nil` | Representación nativa del lenguaje / native representation |
| `insert_tail` y `enqueue` en **`O(1)`** | **`O(n)`**: reconstruyen el tramo desde la cabeza; no enlazan desde `tail`/`rear` | Con celdas inmutables, `put_next/2` devuelve una celda inalcanzable desde `head`/`front`: el enlace del nodo anterior solo se puede reconstruir / with immutable cells the copy is unreachable from the head, so the previous link can only be rebuilt |
| `delete`, `pop`, `dequeue` exponen el resultado por `out` | Devuelven la tupla `{resultado, estructura}` | En un lenguaje inmutable el resultado viaja con la estructura nueva / in an immutable language the result travels with the new structure |
| `get_head`, `is_empty`, `insert_head` (`snake_case`) | `head_value/1`, `empty?/1`, `insert_head/2` | Convención de Elixir: predicados con `?` y nombres en `snake_case` / Elixir convention: `?` predicates and `snake_case` |
| `src/`, `test/run_tests.ext` | `lib/data_structures_basics.ex`, `test/*_test.exs`, `mix test` | Convención de Mix; ver la nota de desviación / Mix convention; see the deviation note |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `LinkedList.head_value/1` | Lista vacía / empty list | `-1` | `LinkedList.head_value(LinkedList.new())` → `-1` |
| `LinkedList.delete/2` | Valor ausente / absent value | `false` (éxito / success: `true`) | `LinkedList.delete(lista, 99)` → `{false, lista}` |
| `Stack.peek/1`, `Stack.pop/1` | Pila vacía / empty stack | `-1` | `Stack.pop(Stack.new())` → `{-1, pila}` |
| `Queue.peek/1`, `Queue.dequeue/1` | Cola vacía / empty queue | `-1` | `Queue.dequeue(Queue.new())` → `{-1, cola}` |
| `Cell.next/1` | Ausencia de enlace / absent link | `nil` | `Cell.next(Cell.new(10))` → `nil` |
| Inserciones / insertions | Sin límite de capacidad / no capacity limit | No aplica / Not applicable | — |
| Entrada nula / null input | Los parámetros son `integer` / parameters are `integer` | No representable / Not representable | Caso omitido: la especificación no define entradas nulas para este módulo / omitted: the spec defines no null inputs |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Node: inicializar y observar valor/enlace / initialize and observe value/link | Sí | `Node` (`data_structures_basics_test.exs`) | |
| Node: enlazar y recorrer / link and traverse | Sí | `Node` | |
| LinkedList: estado vacío / empty state | Sí | `LinkedList` | `true`, `0`, `-1` |
| LinkedList: insertar por ambos extremos / insert at both ends | Sí | `LinkedList` | `5, 10, 20, 10` |
| LinkedList: eliminar la primera aparición / delete first occurrence | Sí | `LinkedList` | `5, 20, 10`; tamaño `3` |
| LinkedList: valor ausente / absent value | Sí | `LinkedList` | |
| LinkedList: vaciar / empty the list | Sí | `LinkedList` | |
| Stack: estado vacío y extracción fallida / empty state and failed removal | Sí | `Stack` | |
| Stack: LIFO y `peek` no mutante / LIFO and non-mutating `peek` | Sí | `Stack` | |
| Stack: extracción y reutilización / removal and reuse | Sí | `Stack` | `30, 40, 20, 10` |
| Stack: vacío tras extracción / empty after removal | Sí | `Stack` | |
| Queue: estado vacío y extracción fallida / empty state and failed removal | Sí | `Queue` | |
| Queue: FIFO y `peek` no mutante / FIFO and non-mutating `peek` | Sí | `Queue` | |
| Queue: extracción y reutilización / removal and reuse | Sí | `Queue` | `10, 20, 30, 40` |
| Queue: vacío tras extracción / empty after removal | Sí | `Queue` | |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| `insert_tail/2` y `enqueue/2` son `O(n)`; la especificación promete `O(1)` / `O(n)` instead of the promised `O(1)` | La cota de inserción por el final no se cumple / the tail-insertion bound is not met | Declarado en _Adaptaciones idiomáticas_. Con el `Cell` inmutable que exige la especificación no hay mutación del enlace del nodo anterior; una cola de dos pilas daría `O(1)` amortizado, pero la especificación prohíbe sustituir la estructura por colecciones estándar / declared above; a two-stack queue would be `O(1)` amortised, but the spec forbids replacing the structure |
| `append_cell/2`, `append_last/2` y `remove_cell/2` no son *tail-recursive* / not tail-recursive | Pila de llamadas `O(n)` en listas largas / `O(n)` call stack on long lists | La especificación no fija cota de pila; se pueden reescribir con acumulador si se pide / the spec sets no stack bound; they can be rewritten with an accumulator |
| Solo `integer` (sin genéricos) / `integer` only, no generics | `-1` no es almacenable sin confundirse con el fallo / `-1` cannot be stored without clashing with the indicator | Los valores de prueba son enteros positivos, como fija la especificación / tests use positive integers per the spec |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Un único `Cell` lo comparten las tres estructuras; `Stack` gestiona `top` y `Queue` gestiona `front`/`rear` sin delegar en `LinkedList` ni en colecciones estándar. **EN:** The three structures share a single `Cell`; `Stack` manages `top` and `Queue` manages `front`/`rear` with no delegation to `LinkedList` or standard collections.
- **ES:** Ninguna operación lanza excepciones: el fallo es un valor (`-1` o `false`). El caso nulo no existe (`integer`) y la ausencia de enlace es `nil`. **EN:** No operation throws: failure is a value (`-1` or `false`). There is no null case (`integer`) and an absent link is `nil`.
- **ES:** `insert_tail/2` y `enqueue/2` no leen `tail`/`rear` para enlazar (reconstruyen desde la cabeza); tras `delete/2`, `tail` puede seguir apuntando a una celda retirada, algo que el contrato no expone y ninguna operación lee. **EN:** `insert_tail/2` and `enqueue/2` do not read `tail`/`rear` to link (they rebuild from the head); after `delete/2`, `tail` may still point at a removed cell, which the contract does not expose and no operation reads.
- **ES:** Elixir garantiza TCO, pero los ayudantes de reconstrucción (`append_cell/2`, `append_last/2`, `remove_cell/2`) no son *tail-recursive* porque reconstruyen a la vuelta. **EN:** Elixir guarantees TCO, but the rebuild helpers (`append_cell/2`, `append_last/2`, `remove_cell/2`) are not tail-recursive because they rebuild on the way back.
- **ES:** Los tests recorren cada tabla de la especificación en una sola prueba por estructura, sobre la misma instancia lógica. **EN:** Tests walk each specification table in a single test per structure, on the same logical instance.
- **ES:** Sin imports hacia otros módulos del roadmap. **EN:** No imports from other roadmap modules.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README. / The native suite ran and its real output is copied here.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_. / Every spec case has its row in _Test coverage_.
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_. / Every deviation from the pseudocode or expected location is under _Idiomatic adaptations_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_. / Every operation with a possible failure is under _Failure indicators_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas. / No author absolute paths, credentials or invented output.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe. / Relative links resolve inside the repository and the document is bilingual.
- [x] Ninguna sección repite lo que ya dice la especificación. / No section repeats what the specification already says.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics) |
| Módulo homologado del lenguaje / Homologated module | [`elixir/core/foundations/numbers/`](../../foundations/numbers/) |
| Documentación oficial del lenguaje / Language official docs | [Elixir — documentación oficial / official documentation](https://elixir-lang.org/docs.html) |

---

*[← Volver a Algoritmos Puros](../README.md) | [↑ Volver a Core](../../README.md)*

