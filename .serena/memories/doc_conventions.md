# Documentation Conventions

## Function Documentation Template
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

## Class Documentation Template
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
Description with parameters and examples.
```

## Cross-References
- Use `<<class-name>>` for class references
- Use `<<func-name>>` for function references
- Anchors defined with `[[anchor-name]]`

## Code Blocks
- Use `[source,c]` for NXSL code highlighting
- No language-specific syntax highlighting available (uses C as fallback)
