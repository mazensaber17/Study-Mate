# StudyMate source layout

This is the initial project skeleton. Feature behavior and final UI are intentionally not implemented yet.

```text
lib/
  api/                         Dio client and endpoint definitions
  model/                       Feature data models
  repository/                  StudyMate data access used by ViewModels
  ui/
    auth/registration/         Registration view and cubit/
    home/
      news/cubit/               News states and NewsViewModel
      chat_ai/cubit/            Chat states and ChatAiViewModel
      summarizer/cubit/         Summarizer states and ViewModel
      settings/cubit/           Settings states and ViewModel
    shared/widgets/            Reusable UI components and state widgets
    splash/                    Splash view
  utils/                       Theme, design tokens, assets, dependencies
  app.dart                     MaterialApp configuration
  main.dart                    Application entry point
```

The organization follows the reference branch's clear `api/`, `model/`, `ui/`,
and `utils/` grouping. Like that branch, every feature state holder is named
`*ViewModel` and its states are kept in a sibling `cubit/` directory. The
StudyMate-specific additions are `app.dart`, routing, feature repositories,
and shared widgets; these remain because StudyMate has multiple main flows and
uses Dio with a small dependency container.

Figma-derived colors and typography references are centralized in
`utils/app_colors.dart`, `utils/app_styles.dart`, and `utils/app_theme.dart`.
Final exported logo and icon assets are intentionally not added until the
approved Figma exports are available.
