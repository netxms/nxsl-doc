# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- `make prepare` - Install dependencies and prepare build environment
- `make html` - Build HTML documentation
- `make pdf` - Build PDF documentation
- `make all` - Build both HTML and PDF documentation
- `make clean` - Remove built files
- `make watch` - Watch for file changes and rebuild automatically

## Development Environment
- Ruby-based documentation using Asciidoctor
- Content is written in AsciiDoc format (.adoc files)
- Documentation is organized by:
  - Language syntax
  - Functions (categorized by domain)
  - Classes
  - Constants

## Documentation Style Guidelines
- Use descriptive, consistent naming for function and class documentation
- Follow existing format for documenting classes and functions
- Respect the hierarchical organization of documentation
- Maintain cross-references between related functions and classes
- Always include code examples in documentation