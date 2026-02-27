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
== FunctionName()

FunctionName(param1, param2) => <<class-returntype>>::
Description paragraph. For multi-paragraph descriptions, use + continuation:
+
Additional paragraph text.
+
.Parameters
[cols="1,1,3" grid="none", frame="none"]
|===
|param1|Type|Description.
|param2|Type|Description.
|===
+
.Return
Return value description.
+
[.source]
....
// Example code
....
```

**Key formatting rules:**
- Signature uses definition list format with `::` at end
- No blank line after `::` - description starts immediately
- Use `+` between paragraphs within description
- Use `+` before `.Parameters`, `.Return`, and `[.source]` sections
- Return types: primitives as plain text (`int`, `bool`, `string`), objects as cross-references (`<<class-node>>`)
- Examples use `[.source]` with `....` delimiters (not `[source,c]` with `----`)

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

**Function argument mixing**: Named arguments (e.g., `arg3: "value"`) count toward positional parameter indices. In `myFunc("first", arg3: "third", "second")`, the named parameter `arg3` occupies position 2, making `$2` equal to `"third"`. This can create confusing behavior when mixing argument styles.

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

**Version markers** (Python-style with colored left borders):
```asciidoc
[.version-added]
Added in version 5.3

[.version-changed]
Changed in version 4.4.1: Description of change.

[.version-deprecated]
Deprecated in version 5.0. Use <<replacement>> instead.
```

For inline short markers: `[.version-added]#Added in version 5.1#`

Use `+` continuation to attach version markers to description list items:
```asciidoc
`methodName() => Type`::
Description text.
+
[.version-added]
Added in version 5.3
```

**Version marker styling evolution**: Final design uses only colored italic text (no borders, no backgrounds) for minimal visual clutter. Initial attempts with borders and backgrounds proved too visually heavy. Color scheme: green (#2d6a2e) for added, amber (#856404) for changed, red (#721c24) for deprecated.

**Version marker placement**: Always place BEFORE descriptions for better visibility. For parameters in tables, place after the table closes but before the next section (`.Return`, `.Example`, etc.). Use format "Added in version X.X: `parameter` parameter" when noting specific parameters.

**CSS spacing fix**: Reset `<p>` margin to 0 inside version marker divs to prevent excessive spacing from AsciiDoc's default paragraph margins:
```css
.version-added p,
.version-changed p,
.version-deprecated p {
    margin: 0;
}
```

## Cross-Referencing Source Code

- NetXMS source code is at `/Users/alk/Development/netxms/netxms-master`
- NXSL global function implementations: `src/libnxsl/functions.cpp`, registered in `src/libnxsl/env.cpp`
- NXSL string method implementations: `src/libnxsl/string.cpp`
- To determine which version a feature was added in, find the commit and check which stable branch contains it: `git branch -a --contains <commit-hash>` — branch `stable-X.Y` means version X.Y
- YouTrack issue tracker (track.radensolutions.com) requires authentication — ask user for issue details if needed

## Where to Document

- **Global functions** (e.g., `LevenshteinDistance`): separate file in `functions/<category>/` or `functions/`, included via `func-*.adoc`
- **String methods** (e.g., `fuzzyEquals`): inline in `language-syntax.adoc` under the string methods section (alphabetically ordered)
- **Class attributes/methods**: in `classes/<classname>.adoc`

## Documentation Writing Patterns

**Problem-first structure**: When explaining solutions (like `global` keyword), show the problem first to establish motivation:
1. State default behavior
2. Show failing example
3. Explain the error
4. Introduce solution
5. Show working example
6. Confirm success

This prevents reader confusion from examples that appear to contradict the opening statement.

**Multi-option features**: When documenting features with multiple approaches, use numbered methods with clear recommendations:
- Number each method explicitly (1, 2, 3...)
- Mark the recommended approach in the heading
- Provide "when to use this" guidance for each
- Add cautionary notes for confusing or edge-case patterns
- Present the standard/recommended approach first

**Inline comments in examples**: Use inline comments to explain non-obvious behavior, especially for edge cases:
```nxsl
// $2: third       (named parameter arg3 occupies position 2)
```
