# HiredStep

An Android app, built with Flutter, for tracking job and internship applications: where each one stands, what the next step is, and when it happens.

**Status:** planning done, Phase 1 (MVP, `v0.1.0`) in progress.

## Why

When you apply to many places at once, the details end up scattered across emails, chats, and notes. This app keeps every application in one place, with a clear history of each step and its date.

## Features

**Phase 1 (MVP)**

- [ ] Add, edit, and delete applications
- [ ] Application list with status badges
- [ ] Application detail with step-by-step history
- [ ] Change status with a date (defaults to today)
- [ ] Local storage that works offline
- [ ] Back up and restore through a mock REST API

**Phase 2 (planned)**

- [ ] Search and filter
- [ ] Board view grouped by stage
- [ ] Custom statuses inside five fixed stages
- [ ] Optional planned process with progress
- [ ] Reminders, calendar, and statistics
- [ ] Side drawer for settings

Details: [docs/PRD.md](docs/PRD.md)

## Screenshots

_Added at the first release._

## Tech stack

Choices marked _to decide_ are recorded in `docs/decisions/` when made.

| Area | Choice |
|---|---|
| Framework | Flutter and Dart |
| Architecture | MVVM with the repository pattern |
| State management | _to decide_ (Provider or Riverpod) |
| Local database | _to decide_ (SQLite-based package) |
| HTTP | _to decide_ (`http` or `dio`) |
| Mock API | _to decide_ (json-server or similar) |
| Testing | `flutter_test`, widget tests |

## Architecture

```text
Screen  ->  ViewModel  ->  Repository (interface)  ->  Local database
                                                   ->  Remote API (back up and restore)
```

The UI only talks to view models, and view models only talk to repository interfaces, so storage and network can change without touching the screens.

## Getting started

**Prerequisites:** Flutter SDK, Android Studio with an Android emulator.

```bash
git clone <repository-url>
cd <repository-folder>
flutter pub get
flutter run
```

Other commands (available as each part is built):

```bash
flutter test          # run unit and widget tests
flutter build apk     # build an installable APK
```

The mock server instructions will live in `mock_server/README.md`.

## Documentation

| Document | Purpose |
|---|---|
| [docs/PRD.md](docs/PRD.md) | Requirements, user stories, data model |
| `docs/api.md` | Mock API contract (added with Phase 1 back up and restore) |
| `docs/test-cases.md` | Manual test cases |
| `docs/decisions/` | Short notes explaining technical choices |
| [CHANGELOG.md](CHANGELOG.md) | Release history |

## Git workflow

- One branch per stage of work, merged into `main` through a pull request.
- Commit messages use a prefix: `feat:`, `fix:`, `docs:`, `test:`, `chore:`, `refactor:`.
- Each user story has an issue. A pull request uses `Refs #n` while a story is in progress and `Closes #n` when it completes the story.

## Roadmap

| Stage of work | Result |
|---|---|
| 0. Setup | Repository, PRD, README, issues |
| 1. UI basics | List screen with dummy data |
| 2. Form and navigation | Add, edit, detail, change status |
| 3. State management | View models and repository |
| 4. Local storage | Data persists |
| 5. Testing | Unit tests, widget tests, test cases |
| 6. API | Back up and restore against a mock API |
| 7. Release | `v0.1.0` APK, screenshots, changelog |
| 8. Phase 2 | Features one by one |

## Author

Muhammad Rashif Aminurrohim

## License

_To be added._
