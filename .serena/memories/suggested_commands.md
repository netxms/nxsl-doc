# Suggested Commands for NXSL Documentation

## Build Commands
- `make prepare` - Install Ruby dependencies via Bundler (run first)
- `make html` - Build HTML to `build/nxsl.html`
- `make pdf` - Build PDF to `build/nxsl.pdf`
- `make all` - Build both formats
- `make watch` - Auto-rebuild on file changes (uses fswatch on macOS)
- `EXTENDED=yes make html` - Build with extended content flag

## System Utilities (macOS)
- `ls`, `cd`, `grep`, `find` - Standard unix utilities
- `fswatch` - File watching (used by make watch)
- `bundler` - Ruby dependency management

## Testing Changes
After editing documentation, run `make html` to verify AsciiDoc syntax is valid.
