# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- `make prepare` - Install Ruby dependencies via Bundler (run first)
- `make html` - Build HTML to `build/nxsl.html`
- `make pdf` - Build PDF to `build/nxsl.pdf`
- `make all` - Build both formats
- `make watch` - Auto-rebuild on file changes (uses fswatch on macOS, inotifywait on Linux)
- `EXTENDED=yes make html` - Build with extended content flag

## Architecture

**Entry point**: `index.adoc` includes all major sections:
- `language-syntax.adoc` - NXSL language reference
- `functions.adoc` → `func-*.adoc` → `functions/<category>/*.adoc` - Function docs organized by category
- `classes.adoc` → `classes/*.adoc` - Class documentation (70+ classes)
- `constants.adoc` - Global constants
- `deprecated.adoc` → `deprecated/*.adoc` - Deprecated functions

**Function categories** (in `func-*.adoc` files):
- `func-math.adoc` - Math package functions
- `func-string.adoc`, `func-time.adoc`, `func-objects.adoc`, `func-datacollection.adoc`, `func-alarms.adoc`, `func-events.adoc`, `func-misc.adoc`, `func-base64.adoc`, `func-crypto.adoc`, `func-files.adoc`, `func-net.adoc`

**Class inheritance**: Many classes extend `NetObj` or `DataCollectionTarget`. Cross-references use `<<class-name>>` syntax.

## Documentation Patterns

**Function template** (`functions/<category>/<name>.adoc`):
```asciidoc
[.nxsl-function]
[[func-category-name]]
== Category::Name()

[source,c]
----
Category::Name(param) => ReturnType
----

Description.

.Parameters
[cols="1,1,3" grid="none", frame="none"]
|===
|param|Type|Description.
|===

.Return
Return description.

.Example
[source,c]
----
// Example code
----
```

**Class template** (`classes/<name>.adoc`):
```asciidoc
[.nxsl-class]
[[class-name]]
=== ClassName

Description. Extends <<class-parent>>.

==== Instance attributes
`attributeName => Type`::
Description.

==== Instance methods
`methodName(params) => ReturnType`::
Description with parameters table and examples.
```

## Key Files
- `lib/stats.rb` - Asciidoctor extension for analytics (CI only)
- `netxms-theme.yml` - PDF styling configuration
- `Gemfile` - Ruby dependencies (asciidoctor 2.0.26, asciidoctor-pdf 2.3.24, coderay 1.1.3)

## NXSL Language Notes

**Return value semantics**:
- Expression without semicolon → implicitly returns the expression's value
- Statement with semicolon but no `return` → returns `null`
- Semicolons are NOT required in NXSL (contrary to C-like expectations)

**Implicit main**: Code outside functions is wrapped into `$main()` (note the `$` prefix).

**main() override behavior**: If both explicit `main()` and top-level code exist, the top-level code is silently discarded - only `main()` executes.

**Function argument counts**:
- `trace(level, message)` - exactly 2 args, use string concatenation: `trace(3, "msg " .. value)`
- `println(...)` - variadic, accepts multiple args: `println("a", "b", "c")`

## Documentation Patterns Notes

**Custom anchors**: Add explicit `[[anchor-name]]` for sections that need cross-references. Don't rely on auto-generated anchors.

**Operator documentation**: For new operators in `language-syntax.adoc`, use the standard table format:
```asciidoc
[cols="<33,<33,<33",options="header"]
|===
| Example| Name| Result
|`syntax`| Name| Description.
|===
```

**Multi-location feature docs**: Document new language features in three places:
- `language-syntax.adoc` - Full reference with examples
- `guide/getting-started.adoc` - Beginner introduction in relevant section
- `guide/working-with-netxms.adoc` - Brief mention in Best Practices