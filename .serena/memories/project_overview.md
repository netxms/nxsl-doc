# NXSL Documentation Project Overview

## Purpose
Official documentation for NXSL (NetXMS Scripting Language) - an embedded scripting language for the NetXMS network monitoring system.

## Tech Stack
- **Build System**: AsciiDoc with Asciidoctor (Ruby-based)
- **Output Formats**: HTML and PDF
- **Dependencies**: Ruby gems (asciidoctor 2.0.26, asciidoctor-pdf 2.3.24, coderay 1.1.3)
- **Build Tool**: Makefile

## Documentation Structure
- Entry point: `index.adoc`
- Major sections: language-syntax, tutorial, functions, classes, constants, grammar, examples, deprecated, alphabetical-index
- Shared includes: `classes/_shared/` with reusable NetObj and DataCollectionTarget attributes/methods
- Guide content: `guide/` directory (getting-started.adoc, working-with-netxms.adoc)
- Functions organized by use-case in `func-*.adoc` files (10 groups)
- Classes in `classes/` directory (70+ classes) organized by domain (11 groups)
- Deprecated functions in `deprecated/` directory
- Alphabetical index in `index-alphabetical.adoc` (functions, deprecated, classes)

## Function Categories
- Math (package-based, `Math::` prefix)
- String, Time, Objects, DataCollection, Alarms, Events, Misc
- Base64, Crypto, Files, Net (package-based, respective prefixes)

## Key Patterns
- Functions use `[[func-name]]` anchors for cross-references
- Classes use `[[class-name]]` anchors
- Cross-references via `<<anchor-name>>` syntax
- Code blocks use `[source,c]` syntax highlighting
