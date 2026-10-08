# StudyMate

Flutter graduation project. This setup step establishes the source layout, theme foundations, and design-token records from the StudyMate Figma file. Screen UI and feature logic have not been implemented yet.

## Architecture

The project follows a small MVVM + Cubit structure with Dio for networking:

- `lib/ui/` contains feature Views and Cubit/ViewModel state holders.
- `lib/repository/` is reserved for feature data access.
- `lib/api/` contains shared Dio configuration and later endpoint definitions.
- `lib/model/` contains feature data models.
- `lib/utils/` contains shared theme and design tokens.
- `assets/` contains design assets and the extracted token record.

The grouping follows the reference project's `api/`, `model/`, `ui/`, and `utils/` organization, with a repository layer added for StudyMate's requested architecture.

## Design resources

- Colors: `lib/utils/app_colors.dart` and `assets/design_tokens.md`
- Font family helpers: `lib/utils/app_styles.dart`
- Figma font notes: `assets/fonts/README.md`
- Custom icon export notes: `assets/icons/README.md`

The Figma connector reached its plan limit before custom icon/image files could be downloaded. The project does not contain replacement or reconstructed artwork.