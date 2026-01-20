# Session: Documentation Migration Planning
Date: 2026-01-20

## Purpose
Planning session for unified NetXMS documentation site using Antora.

## Key Decisions Made

### Architecture
- **Site Generator**: Antora
- **Repository**: Monorepo at `/Users/alk/Development/netxms/docs`
- **Versioning**: Per NetXMS release (v5.0, v5.1, etc.)
- **Branch Strategy**: `master` → latest, `vX.Y` → versioned
- **Modules**: Admin Guide + NXSL Reference (separate but interlinked)
- **Translations**: Separate directories (future task)

### Technical Choices
- **UI Bundle**: Default Antora UI
- **Glossary**: Shared across modules
- **Search**: Lunr.js (Antora built-in)
- **NXSL Source**: `restructure` branch (stable)
- **CI/CD**: GitHub Actions, self-hosted (separate task)

## Source Material Analysis

### Admin Guide (netxms/netxms-doc)
- Location: `/Users/alk/Development/netxms/netxms-doc/admin/`
- Format: Sphinx + RST
- Files: 49 RST files
- Requires: Full conversion to AsciiDoc

### NXSL Reference (netxms/nxsl-doc)
- Location: `/Users/alk/Development/netxms/nxsl-doc/`
- Branch: `restructure`
- Format: Already AsciiDoc
- Structure: `classes/` (72), `functions/` (95), `deprecated/` (76)
- Requires: Reorganization for Antora modules

## Target Structure
```
docs.netxms.org/
├── antora-playbook.yml
├── admin-guide/
│   └── modules/ROOT/pages/ (49 converted files)
├── nxsl/
│   └── modules/ROOT/pages/ (reorganized from nxsl-doc)
└── shared/
    └── modules/ROOT/pages/glossary.adoc
```

## Migration Phases
1. **Foundation Setup**: Antora skeleton, component descriptors
2. **NXSL Migration**: Reorganize restructure branch content
3. **Admin Guide Migration**: RST → AsciiDoc conversion
4. **Integration**: Cross-references, glossary, search
5. **CI/CD**: GitHub Actions (separate task)

## Files Created
- `/Users/alk/Development/netxms/docs/PROJECT_SPEC.md` - Full specification
- `/Users/alk/Development/netxms/docs/TASKS.md` - Detailed task checklist

## Cross-Reference Strategy
```asciidoc
# Admin → NXSL
xref:nxsl:functions/findnodeobject.adoc[FindNodeObject]

# NXSL → Admin
xref:admin-guide:concepts.adoc#security[Security Concepts]

# Glossary
xref:shared:glossary.adoc#term[Term]
```

## Resume Instructions
```bash
cd /Users/alk/Development/netxms/docs
# "continue with Phase 1" to start implementation
```

## Status
Planning complete. Ready for Phase 1 implementation.
