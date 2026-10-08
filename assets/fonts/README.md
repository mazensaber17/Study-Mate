# StudyMate fonts

Font families identified in Figma and exposed through `google_fonts`:

- **Space Grotesk** — primary UI text; Regular and Bold are visible.
- **Fraunces** — StudyMate wordmark and prominent headings; SemiBold, SemiBold Italic, and Bold are visible.
- **JetBrains Mono** — compact mode/screen labels; Regular and Medium are visible.

Figma records font family names and styles, but does not embed installable font binaries in this file. `AppStyles` uses the matching Google Fonts families. The package can fetch fonts at runtime; for offline or production bundling, add the matching licensed font files here and register them as assets.