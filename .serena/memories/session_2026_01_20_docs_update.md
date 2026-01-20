# Session 2026-01-20: Documentation Updates

## Summary
Documentation improvements focusing on accuracy, modernization, and clarity.

## Changes Made

### Commits
1. **a955084** - Fix CheckTrustedObjects config parameter name and default value
   - Renamed `CheckTrustedNodes` → `Objects.Security.CheckTrustedObjects`
   - Corrected default from enabled (1) to disabled (0)
   - Updated in `index.adoc` and `examples.adoc`

2. **97261a0** - Improve getting started guide and modernize script examples
   - Updated script execution contexts documentation
   - Removed deprecated `function main()` pattern from all examples
   - Added `nxscript` command-line tool documentation
   - Fixed broken table delimiter in Context Variables section

### Key Corrections
- **Script execution**: Best testing method is right-click → "Execute script" (not Script Library)
- **Script Library**: For storing reusable scripts (`import script_name`)
- **Filter Scripts**: Used in EPP, not DCIs
- **main() function**: Deprecated - interpreter auto-wraps code into implicit main()
- **trace()**: Outputs to both debug console and log file (if level above current debug level)
- **nxscript**: Command-line tool bundled with server for testing scripts

### Files Modified
- `index.adoc` - CheckTrustedObjects parameter
- `examples.adoc` - CheckTrustedObjects, removed main() wrapper
- `guide/getting-started.adoc` - Script contexts, nxscript, execution examples
- `guide/working-with-netxms.adoc` - Fixed table delimiter
- `tutorial.adoc` - Simplified Hello World, added main() deprecation note

## Patterns Learned
- NXSL function definitions can be placed anywhere; code outside executes sequentially
- Server config parameters use dot notation: `Objects.Security.CheckTrustedObjects`
- AsciiDoc tables require `|===` (three equals), not `|==`
