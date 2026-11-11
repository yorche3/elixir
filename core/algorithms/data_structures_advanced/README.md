# Data Structures Advanced — Elixir

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced) en **Elixir**, con un enfoque manual y minimalista.

**ES:** Nodos con enlaces múltiples (`TreeNode` con valor embebido) y registro propio de vértices (`GraphNode` y `Graph`), implementando un árbol binario de búsqueda y un grafo dirigido sobre structs inmutables sin dependencias externas. Se ejecuta con `mix test` (ExUnit) y el verificador estático es `mix compile --warnings-as-errors` junto a `mix format --check-formatted`.

**EN:** Nodes with multiple links (`TreeNode` with embedded value) and custom vertex registry (`GraphNode` and `Graph`), implementing a binary search tree and a directed graph over immutable structs without external dependencies. Run with `mix test` (ExUnit); the static verifier is `mix compile --warnings-as-errors` alongside `mix format --check-formatted`.

---

## 📂 Archivos y estructura / Files & Structure

Describe la estructura del proyecto y el propósito de cada archivo.

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`lib/data_structures_advanced.ex`](lib/data_structures_advanced.ex) | Módulo `DataStructuresAdvanced` con los tipos anidados `TreeNode`, `BinaryTree`, `GraphNode` y `Graph` / `DataStructuresAdvanced` with nested types `TreeNode`, `BinaryTree`, `GraphNode`, and `Graph` |
| [`test/data_structures_advanced_test.exs`](test/data_structures_advanced_test.exs) | Suite ExUnit con 24 tests unitarios (uno por caso de la especificación) / ExUnit test suite with 24 tests (one per specification case) |
| [`test/test_helper.exs`](test/test_helper.exs) | Arranque de ExUnit / ExUnit boot script |
| [`mix.exs`](mix.exs) | Configuración del proyecto Mix / Mix project configuration |
| [`.formatter.exs`](.formatter.exs) | Configuración de formato de código / Formatter configuration |
| `.gitignore` | Exclusiones de Git (`_build/`, etc.) / Git ignored files |
| `README.md` | Documentación del módulo / Module documentation |

**Nota de desviación / Deviation note:**

**ES:** La especificación propone `src/data_structures_advanced.ext` y `test/run_tests.ext`. En Elixir se utiliza la convención canónica de Mix: código fuente en `lib/` y pruebas en `test/`. No hay script `run_tests`; `mix test` actúa como test runner nativo descubriendo automáticamente `test/**/*_test.exs`.

**EN:** The specification suggests `src/data_structures_advanced.ext` and `test/run_tests.ext`. In Elixir, canonical Mix conventions are followed: source code in `lib/` and tests in `test/`. There is no `run_tests` script; `mix test` acts as the native test runner, automatically discovering `test/**/*_test.exs`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto generado con `mix new data_structures_advanced` y adaptado a mano. Debido a la inmutabilidad estricta de Elixir, las estructuras no mutan in-place: toda inserción o actualización reconstruye el camino afectado en el struct y devuelve una tupla `{booleano_exito, nueva_estructura}` o la nueva estructura directamente, manteniendo la integridad referencial y las complejidades amortizadas/asintóticas requeridas. El registro de vértices se gestiona manualmente mediante enlace simple entre nodos `GraphNode` (`next_vertex`), sin diccionarios ni tablas hash.

**EN:** Project generated using `mix new data_structures_advanced` and adapted by hand. Due to Elixir's strict immutability, structures do not mutate in-place: every insertion or update rebuilds the affected path within the struct and returns a `{success_boolean, new_structure}` tuple or the new struct directly, preserving referential integrity and the required asymptotic complexities. The vertex registry is managed manually via a singly-linked chain of `GraphNode` records (`next_vertex`), without dictionaries or hash tables.

---

## 📄 Configuración clave / Key Configuration

- `mix.exs`: define la aplicación `:data_structures_advanced` con versión Elixir `~> 1.20`, sin dependencias externas (`deps: []`).
- `.formatter.exs`: configuración por defecto para `mix format`.
- `test/test_helper.exs`: inicia ExUnit con `ExUnit.start()`.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
mix compile --force --warnings-as-errors
mix format --check-formatted
mix test
```

**Salida real / Actual output:**

```text
$ mix compile --force --warnings-as-errors
Compiling 1 file (.ex)
Generated data_structures_advanced app

$ mix format --check-formatted
(sin salida / no output; código de salida / exit code 0)

$ mix test
Running ExUnit with seed: 785214, max_cases: 32

........................
Finished in 0.09 seconds (0.09s async, 0.00s sync)

Result: 24 passed
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `TreeNode.new/1` | `integer → TreeNode.t()` | `O(1)` | Valor embebido, enlaces `left` y `right` en `nil` / Embedded value, `nil` links |
| `TreeNode.value/1` | `TreeNode.t() → integer` | `O(1)` | Selector de valor / Value selector |
| `TreeNode.left/1`, `TreeNode.right/1` | `TreeNode.t() → TreeNode.t() \| nil` | `O(1)` | Selectores de enlace / Link selectors |
| `TreeNode.put_left/2`, `TreeNode.put_right/2` | `TreeNode.t(), TreeNode.t() \| nil → TreeNode.t()` | `O(1)` | Reconstrucción funcional inmutable / Functional immutable rebuild |
| `BinaryTree.new/0` | `→ BinaryTree.t()` | `O(1)` | Árbol vacío (`root: nil, count: 0`) / Empty tree |
| `BinaryTree.insert/2` | `BinaryTree.t(), integer → {boolean, BinaryTree.t()}` | `O(h)` | Inserción en ABB recursiva funcional (`h` = altura); duplicado idempotente no incrementa tamaño / Functional recursive BST insertion; idempotent duplicate preserves size |
| `BinaryTree.contains?/2` | `BinaryTree.t(), integer → boolean` | `O(h)` | Búsqueda binaria recursiva guiada por invariante de orden / Recursive binary search guided by BST invariant |
| `BinaryTree.empty?/1` | `BinaryTree.t() → boolean` | `O(1)` | Comprueba si `count == 0` / Checks if `count == 0` |
| `BinaryTree.size/1` | `BinaryTree.t() → non_neg_integer` | `O(1)` | Retorna `count` acumulado / Returns accumulated `count` |
| `GraphNode.new/1` | `integer → GraphNode.t()` | `O(1)` | Nodo interno con etiqueta, vecinos vacíos y `next_vertex: nil` / Internal node with label, empty neighbors, and `next_vertex: nil` |
| `Graph.new/0` | `→ Graph.t()` | `O(1)` | Grafo vacío (`vertices: nil, vertex_count: 0, edge_count: 0`) / Empty graph |
| `Graph.add_vertex/2` | `Graph.t(), integer → {true, Graph.t()}` | `O(V)` | Búsqueda manual de etiqueta; antepone nuevo `GraphNode` si no existe / Manual label lookup; prepends new `GraphNode` if absent |
| `Graph.add_edge/3` | `Graph.t(), integer, integer → {boolean, Graph.t()}` | `O(V + d(u))` | Búsqueda de extremos en registro enlazado; inserción ordenada en adyacencia si no existe / Endpoint lookup in linked registry; sorted insertion into adjacency list |
| `Graph.has_edge?/3` | `Graph.t(), integer, integer → boolean` | `O(V + d(u))` | Búsqueda de extremos e inspección de lista ordenada de adyacencia / Endpoint lookup and adjacency list check |
| `Graph.get_neighbors/2` | `Graph.t(), integer → [integer] \| nil` | `O(V)` | Retorna copia inmutable de la lista de vecinos; `nil` si el vértice no existe / Returns immutable neighbor list; `nil` if vertex is missing |
| `Graph.empty?/1` | `Graph.t() → boolean` | `O(1)` | Comprueba si `vertex_count == 0` / Checks if `vertex_count == 0` |
| `Graph.vertex_count/1` | `Graph.t() → non_neg_integer` | `O(1)` | Retorna total de vértices / Returns vertex count |
| `Graph.edge_count/1` | `Graph.t() → non_neg_integer` | `O(1)` | Retorna total de aristas / Returns edge count |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Módulos anidados dentro de `DataStructuresAdvanced` (`TreeNode`, `BinaryTree`, `GraphNode`, `Graph`) | Módulos globales sueltos | Evita colisiones en el namespace global de la BEAM y agrupa los tipos bajo el contrato del módulo / Prevents global BEAM namespace pollution and scopes types under module contract |
| Valor embebido en `TreeNode` y `GraphNode` | Herencia de una base común `Node` | Elixir no tiene herencia orientada a objetos basada en clases; el contrato permite explícitamente valor embebido (composición) / Elixir lacks class-based OOP inheritance; the contract explicitly allows embedded values (composition) |
| Registro canónico de vértices enlazado a mano (`GraphNode.next_vertex`) | `Map` o `MapSet` de biblioteca estándar | La especificación prohíbe delegar el registro de vértices o su búsqueda en mapas/tablas hash de biblioteca; exige estructura y recorrido manual `O(V)` / The specification forbids delegating vertex registry to library maps/hash tables; mandates manual structure and `O(V)` traversal |
| Lista de vecinos ordenada mantenida con inserción ordenada manual (`insert_sorted/2`) | `Enum.sort/1` en cada consulta | La especificación exige que los vecinos se mantengan ordenados en la inserción con coste `O(d(u))` y prohíbe delegar en ordenaciones de biblioteca / The specification requires sorted adjacency on insertion in `O(d(u))` and forbids delegating to library sorting |
| Retorno de tuplas `{status, new_structure}` para mutaciones funcionales | Lanzar excepciones o devolver solo la nueva estructura | Elixir es inmutable; las operaciones con posible fallo (`add_edge`) o indicación de éxito deben devolver el resultado observable junto a la estructura actualizada / Elixir is immutable; operations needing success/failure indication must return status alongside the updated structure |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `type Node` base heredada por `TreeNode` y `GraphNode` | Valor embebido directo (`defstruct value: nil, ...`) en cada nodo | Elixir es un lenguaje funcional sin herencia de clases; la especificación permite explícitamente la forma de valor embebido / Elixir is functional without class inheritance; the specification explicitly permits embedded values |
| Mutación in-place de campos y punteros (`current.left = ...`, `source.neighbours = ...`) | Reconstrucción inmutable del camino con structs funcionales | Elixir no admite mutación de memoria; se reconstruyen los nodos afectados retornando nuevas instancias / Elixir does not allow memory mutation; affected nodes are rebuilt returning new instances |
| `is_empty()`, `contains(v)`, `has_edge(u, v)` | `empty?/1`, `contains?/2`, `has_edge?/3` | Convención idiomática de nombrado en Elixir para predicados booleanos / Idiomatic Elixir naming convention for boolean predicates |
| `src/` y `test/run_tests.ext` | `lib/` y `test/` ejecutado con `mix test` | Convención estándar del sistema de construcción Mix y framework ExUnit / Standard Mix build system and ExUnit framework layout |
| Modificación de una copia devuelta de vecinos en tests de aislamiento | Verificación de inmutabilidad referencial de listas compartidas | En Elixir las listas son inmutables; no existe mutación externa de una colección devuelta que pueda alterar el grafo original / In Elixir lists are immutable; external modification of a returned collection cannot alter the original graph |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.left/1`, `TreeNode.right/1` | Enlace ausente / Absent link | `nil` | `TreeNode.left(TreeNode.new(10))` → `nil` |
| `BinaryTree.contains?/2` | Valor no encontrado en el árbol / Value absent from tree | `false` | `BinaryTree.contains?(BinaryTree.new(), 50)` → `false` |
| `Graph.add_edge/3` | Uno o ambos extremos no existen / Missing source or target vertex | `{false, graph}` | `Graph.add_edge(graph, 10, 99)` → `{false, graph}` |
| `Graph.has_edge?/3` | Arista inexistente o extremo no registrado / Missing edge or vertex | `false` | `Graph.has_edge?(graph, 10, 30)` → `false` |
| `Graph.get_neighbors/2` | Vértice no registrado / Unregistered vertex | `nil` (distinto de `[]` para vértice aislado / distinct from `[]` for isolated vertex) | `Graph.get_neighbors(graph, 99)` → `nil` |
| Entrada nula / Null input | No aplicable a enteros positivos / Not applicable for positive integers | No representable / Not representable | Los tipos contractuales operan sobre enteros (`integer`); la ausencia se modela con `nil` en enlaces / Contractual types operate on integers; absence is modeled with `nil` on links |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| TreeNode: Crear un nodo de árbol | Sí | `test "Crear un nodo de árbol"` (`test/data_structures_advanced_test.exs:75`) | Verifica valor asignado `10` / Verifies assigned value `10` |
| TreeNode: Enlaces iniciales ausentes | Sí | `test "Enlaces iniciales ausentes"` (`test/data_structures_advanced_test.exs:82`) | Verifica `left` y `right` en `nil` / Verifies `nil` links |
| TreeNode: Enlazar dos hijos | Sí | `test "Enlazar dos hijos"` (`test/data_structures_advanced_test.exs:92`) | Enlaza `20` a la izquierda y `30` a la derecha / Links `20` left and `30` right |
| TreeNode: Recorrer cada enlace | Sí | `test "Recorrer cada enlace"` (`test/data_structures_advanced_test.exs:105`) | Recorre enlaces de hijos verificando ausencia de nietos / Traverses children verifying no grandchildren |
| TreeNode: Desenlazar hijos | Sí | `test "Desenlazar hijos"` (`test/data_structures_advanced_test.exs:127`) | Limpieza secuencial con `nil` preservando valores / Sequential clearing with `nil` preserving values |
| TreeNode: Adaptación inmutable | Sí | `test "Adaptación inmutable"` (`test/data_structures_advanced_test.exs:153`) | `put_left` genera nuevo nodo sin mutar original / `put_left` yields new node without mutating original |
| BinaryTree: Crear vacío | Sí | `test "Crear vacío"` (`test/data_structures_advanced_test.exs:166`) | `empty? == true`, `size == 0`, `contains?(50) == false` |
| BinaryTree: Insertar la raíz | Sí | `test "Insertar la raíz"` (`test/data_structures_advanced_test.exs:176`) | Inserta `50`; `size == 1`, `empty? == false`, contiene `50` |
| BinaryTree: Insertar menor y mayor | Sí | `test "Insertar menor y mayor"` (`test/data_structures_advanced_test.exs:186`) | Inserta `50, 30, 70`; `size == 3`, contiene los tres / Contains all three |
| BinaryTree: Ramas de varios niveles | Sí | `test "Ramas de varios niveles"` (`test/data_structures_advanced_test.exs:198`) | Inserta `50, 30, 70, 20, 40`; `size == 5`, contiene todos / Contains all five |
| BinaryTree: Valor ausente en árbol no vacío | Sí | `test "Valor ausente en árbol no vacío"` (`test/data_structures_advanced_test.exs:210`) | `contains?(99) == false`, mantiene `50` y tamaño 1 / Size remains 1 |
| BinaryTree: Duplicado idempotente | Sí | `test "Duplicado idempotente"` (`test/data_structures_advanced_test.exs:223`) | Reinserta `30`; éxito, tamaño se mantiene en `3` / Size stays 3 |
| BinaryTree: Inserciones ordenadas | Sí | `test "Inserciones ordenadas"` (`test/data_structures_advanced_test.exs:236`) | Inserta `20, 30, 40, 50, 70`; tamaño `5`, `contains?(99) == false` |
| Graph: Crear vacío | Sí | `test "Crear vacío"` (`test/data_structures_advanced_test.exs:253`) | `empty? == true`, 0 vértices, 0 aristas, `has_edge?` y `get_neighbors` fallan |
| Graph: Vértice aislado | Sí | `test "Vértice aislado"` (`test/data_structures_advanced_test.exs:266`) | Registra `10`; `empty? == false`, 1 vértice, 0 aristas, vecinos `[]` |
| Graph: Etiquetas no consecutivas y arista dirigida | Sí | `test "Etiquetas no consecutivas y arista dirigida"` (`test/data_structures_advanced_test.exs:276`) | Arista `10 -> 70`; `has_edge?(10, 70) == true`, reverso `false`, 2 vértices, 1 arista |
| Graph: Vértice duplicado conserva adyacencia | Sí | `test "Vértice duplicado conserva adyacencia"` (`test/data_structures_advanced_test.exs:291`) | Re-registra `10`; 2 vértices, 1 arista, vecinos de 10 siguen `[30]` |
| Graph: Arista duplicada | Sí | `test "Arista duplicada"` (`test/data_structures_advanced_test.exs:304`) | Duplica `10 -> 30`; 2 vértices, 1 arista, vecinos siguen `[30]` |
| Graph: Extremo inexistente sin mutación | Sí | `test "Extremo inexistente sin mutación"` (`test/data_structures_advanced_test.exs:317`) | Aristas inválidas fallan sin alterar vértices ni aristas existentes / Invalid edges fail without mutation |
| Graph: Vecinos ordenados y contadores | Sí | `test "Vecinos ordenados y contadores"` (`test/data_structures_advanced_test.exs:354`) | Aristas desordenadas resultan en `[30, 50, 70]`; 4 vértices, 4 aristas / Sorted neighbors verification |
| Graph: Consulta de arista ausente | Sí | `test "Consulta de arista ausente"` (`test/data_structures_advanced_test.exs:378`) | Vértices `10, 30` sin arista; `has_edge?(10, 30) == false`, 2 vértices, 0 aristas |
| Graph: Vecinos de vértice inexistente | Sí | `test "Vecinos de vértice inexistente"` (`test/data_structures_advanced_test.exs:388`) | `get_neighbors(99) == nil`, distinto del `[]` de vértice registrado / Distinct failure vs empty |
| Graph: Bucle y duplicado | Sí | `test "Bucle y duplicado"` (`test/data_structures_advanced_test.exs:400`) | Bucle `10 -> 10` duplicado; `has_edge?(10, 10) == true`, vecinos `[10]`, 1 vértice, 1 arista |
| Graph: Aislamiento del resultado de vecinos | Sí | `test "Aislamiento del resultado de vecinos"` (`test/data_structures_advanced_test.exs:416`) | Resultado previo `[30]` se mantiene inalterado tras insertar arista `10 -> 50` / Prior result unaffected by later insert |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Búsqueda de vértice `O(V)` mediante recorrido lineal de nodos enlazados | Tiempo de localización lineal en grafos con gran número de vértices | Requisito explícito del contrato educativo para evitar colecciones hash de biblioteca; adecuado para el propósito del módulo / Educational contract requirement to avoid library hash collections |
| Inserción recursiva en ABB sin autobalanceo | Árbol degenerado a lista en caso de entradas ordenadas, alcanzando altura `O(n)` | Comportamiento estándar contractual para un ABB puro sin balanceo AVL/Rojinegro / Standard contractual BST behaviour without self-balancing |
| Entrada no entera / Non-integer input | No se soportan otros tipos fuera de enteros positivos | Tipado estricto mediante `@spec` y valores enteros según la especificación / Strict typing via `@spec` and integer values per spec |

---

## 📝 Notas de implementación / Implementation Notes

- **Inmutabilidad y recursión**: En Elixir no existe mutación de estado en memoria. La inserción en el ABB (`BinaryTree.insert/2`) desciende recursivamente por las ramas y reconstruye el camino de retorno vinculando el nuevo subárbol mediante `TreeNode.put_left/2` o `TreeNode.put_right/2`.
- **Registro propio de vértices**: Siguiendo rigurosamente la regla de implementación manual obligatoria, `Graph` no utiliza diccionarios ni conjuntos de la biblioteca estándar para el registro de vértices. El campo `vertices` enlaza una lista encadenada de nodos `GraphNode` mediante el campo `next_vertex`. La búsqueda `find_vertex/2` y la actualización `update_vertex/3` recorren manualmente dicha cadena en `O(V)`.
- **Adyacencia ordenada manual**: Los vecinos se almacenan en una lista de etiquetas enteras mantenida en orden ascendente estricto mediante el helper privado `insert_sorted/2`, sin invocar algoritmos de ordenación externos. La verificación de duplicados previene aristas paralelas y la inserción conserva la cota `O(d(u))`.
- **Ausencia e indicadores**: La ausencia de enlace o de vértice se representa con el átomo nativo `nil`. Se distingue rigurosamente el fallo por vértice inexistente (`nil`) de la lista vacía de vecinos (`[]`) que corresponde a un vértice aislado.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [07_Data_Structures_Advanced.md](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`elixir/core/algorithms/data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`elixir/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/AGENT_Template) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/WORKFLOW) |
| Documentación oficial del lenguaje / Language official docs | [Elixir documentation](https://elixir-lang.org/docs.html) |
