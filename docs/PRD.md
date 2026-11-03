# Product Requirements Document: HiredStep

| | |
|---|---|
| **Version** | 0.1 (draft) |
| **Author** | Muhammad Rashif Aminurrohim |
| **Last updated** | 2 November 2026 |
| **Platform** | Android (Flutter) |
| **Design mockups** | [Canvas](https://claude.ai/artifact/Rf13HgCYsEGT35ubFMiSpf) (screens 1 to 7) |

---

## 1. Overview

### 1.1 Problem

People applying to many internships or jobs at once keep information scattered across emails, chats, and notes. As a result they forget which company is at which stage, when the next interview or test is, and which applications still have no answer.

### 1.2 Goal

A mobile app that records every application in one place, shows where each one stands, and makes upcoming interviews and tests easy to see.

### 1.3 Target users

Students and fresh graduates applying to several companies at the same time. For now, the primary user is the author.

### 1.4 Non-goals (for Phases 1 and 2)

Login and accounts, a real backend (Phase 1 uses a mock REST API instead), iOS, email integration, sharing text into the app, and a web version. See section 8.

---

## 2. Terminology

| Term | Meaning |
|---|---|
| **Application** | One job or internship the user applied to or saved |
| **Stage** | One of five fixed groups: **Saved, Applied, In Process, Offering, Closed**. The board columns are stages |
| **Status** | A user-defined name inside a stage, for example *Interview* or *Technical Test* in In Process. Names and order are editable |
| **History entry** | One record of a status change: the status, a date, an optional time, and optional notes |

An application has exactly one current status at a time. Its history lists every status it went through.

---

## 3. Scope by phase

| Phase | Theme | Contents |
|---|---|---|
| **1 (MVP)** | Manual tracking | Add, list, detail, change status, edit, delete, local storage, default statuses, back up and restore through a mock REST API |
| **2** | Richer views and data | Search and filter, board view, manage statuses, planned process, reminders, calendar, statistics, side drawer |
| **3 and 4** | Out of scope for now | See section 8 |

Phases 3 and 4 are discussed again after Phases 1 and 2 are complete.

---

## 4. Default statuses

| Stage | Default statuses |
|---|---|
| Saved | Saved |
| Applied | Applied |
| In Process | Interview, Technical Test |
| Offering | Offering |
| Closed | Accepted, Rejected, Withdrawn |

In Phase 1 these are fixed. In Phase 2 the user can add, rename, reorder, and delete statuses (US-10).

---

## 5. User stories and acceptance criteria

### Phase 1

**US-1 Add an application**
As an applicant, I want to add an application so that it is recorded in one place.

- Fields: company (required), position (required), stage (Saved or Applied), application date, notes.
- The application date defaults to today.
- The stage at creation is limited to Saved or Applied. A step that already happened is added afterwards with Change status, using its real date. This keeps one date per entry and a complete history.
- Given the add form, when company or position is empty and the user taps Save, then an inline error is shown and nothing is saved.
- Given valid input, when the user taps Save, then the application appears in the list and a first history entry is created.

**US-2 View the list**
As an applicant, I want to see all my applications so that I know where each one stands.

- Each card shows company, position, the current status as a badge colored by its stage, and the application date.
- Given no applications, then an empty state with an Add action is shown.
- The list is sorted by most recent activity.

**US-3 View details**
As an applicant, I want to open an application so that I can see its full history and notes.

- The detail screen shows company, position, current status, notes, and the history in chronological order with stage names and dates.

**US-4 Change status**
As an applicant, I want to change the status of an application so that its progress is visible.

- The user picks a stage, then a status inside that stage. If the stage has only one status, it is selected automatically.
- The date defaults to today and can be changed to the actual date of the step. Time and notes are optional.
- Given valid input, when the user saves, then a history entry is added and the current status is updated.
- The moment of saving is recorded automatically as `createdAt` and is not shown in the interface.

**US-5 Edit and delete**
As an applicant, I want to correct or remove an application.

- The user can edit company, position, application date, and notes.
- Deleting asks for confirmation and removes the application with its history.

**US-6 Persistence**
As an applicant, I want my data to stay after I close the app.

- Given applications exist, when the app is closed and reopened, then all data is still there.
- No network connection is required.

**US-7 Back up and restore through an API**
As an applicant, I want to back up my applications to a server and restore them so that my data is not tied to one device.

- Local storage stays the source of truth. The app works fully offline. A cloud icon in the application list opens a bottom sheet with **Back up** and **Restore**.
- In Phase 1 the server is a mock REST API (JSON over HTTP) following `docs/api.md`. It can later be replaced by a real backend without changing the app.
- Given the server is reachable, when the user taps Back up, then a loading state is shown, all applications and their history are sent, and a success message shows how many were sent.
- Given the server is reachable, when the user taps Restore, then a loading state is shown and the server data is fetched and saved locally. A local record is replaced only when the server copy is newer (`updatedAt`).
- Given the server has no data, then an empty state message is shown and local data is unchanged.
- Given the server is unreachable or returns an error, then a readable error message with a Retry action is shown and local data is not modified.

### Phase 2

| ID | Story | Acceptance criteria |
|---|---|---|
| **US-8** Search and filter | Find applications quickly | Search by company or position. Filter by stage. Filters combine. An empty result shows a message |
| **US-9** Board view | See applications grouped by stage | List and Board toggle. One column per stage, scrolling sideways. Cards show company, status, and date. Changing status moves the card to the right column |
| **US-10** Manage statuses | Fit statuses to my process | Add, rename, reorder, and delete statuses inside each stage. Each stage keeps at least one status. Deleting a status in use asks for a replacement in the same stage. Renaming applies to all applications |
| **US-11** Reminders | Do not miss an interview or test | When a status has a future date and time, the user can enable a local notification. Past or all-day dates create no notification |
| **US-12** Calendar | See upcoming dates | A tab shows dates of In Process and Offering statuses. Tapping an item opens the application |
| **US-13** Statistics | Understand my progress | A tab shows the count per stage and the share of applications that reached In Process and Offering |
| **US-14** Side drawer | Reach settings and profile | Opens from the menu button. Items: Profile, Manage statuses, Reminders, Appearance, Export data, About |
| **US-15** Reschedule | Correct a date | The date and time of a history entry can be edited without creating a new entry |
| **US-16** Planned process | Plan the steps of an application (optional) | In the add and edit form the user can order statuses into a planned process or apply a saved template. The card shows progress (position out of total) only when a plan exists. Statuses outside the plan can still be chosen, and the plan can be edited |

---

## 6. Screens

| # | Screen | Phase |
|---|---|---|
| 1 | Application list | 1 (bottom navigation added in 2) |
| 2 | Add / edit application | 1 |
| 3 | Application detail with history | 1 |
| 4 | Board view with bottom navigation | 2 |
| 5 | Side drawer | 2 |
| 6 | Change status (bottom sheet) | 1 |
| 7 | Manage statuses | 2 |
| 8 | Back up and restore (bottom sheet) | 1 (not yet in the mockups) |

Navigation in Phase 2: bottom navigation with three tabs (Applications, Calendar, Statistics) and a side drawer for settings.

---

## 7. Data model

```text
Application
  id            string
  company       string
  position      string
  appliedAt     date
  notes         string?
  statusId      string        // current status
  plannedStatusIds list<string>? // optional planned process (interface comes in Phase 2)
  createdAt     datetime
  updatedAt     datetime      // used when restoring from the server

Status
  id            string
  name          string
  stage         enum(saved, applied, inProcess, offering, closed)
  sortOrder     int

HistoryEntry
  id            string
  applicationId string
  statusId      string
  date          date          // editable, defaults to today
  time          time?         // optional
  note          string?
  createdAt     datetime      // automatic, not shown
```

Design notes:

- `Stage` is a fixed enum in code. `Status` is user data, so adding or renaming statuses needs no code change.
- The board and statistics read the stage. The detail screen shows the history of statuses the application actually went through, not a fixed list of steps.
- The database is versioned from the first release so later features can be added through migrations.
- The UI talks to a repository interface only, so the storage can later be swapped or complemented by a remote source.

---

## 8. Out of scope and future work

| Item | Notes |
|---|---|
| **Labels** (job type, location) | Planned as a separate many-to-many attribute, independent of status, with a filter row. Can be added after the app is finished with a schema migration, without changing the existing tables |
| Import from other apps | CSV import to move many existing applications at once, including their dates and statuses |
| Paste text and share intent | Parse shared text, suggest a status change, ask for confirmation |
| Compare offers | Needs a new `Offer` entity |
| Email sync, extraction from job URLs | Needs a backend |
| Accounts, cross-device sync, web version | Needs a backend |
| iOS | Share extensions are more complex |

---

## 9. Technical requirements

Mapped to the skills expected for the target internship.

| Requirement | How the project covers it |
|---|---|
| Flutter and Dart UI, forms, navigation | US-1 to US-5 |
| State management (Provider or Riverpod) | Application state is separated from the UI and exposed through a repository |
| REST API integration (requests, JSON parsing, loading and error handling) | US-7 against a mock API, documented in `docs/api.md` |
| Local data (SQLite) with CRUD and caching | US-6, plus restored data cached locally |
| Unit, widget, and functional tests | Section 10 (quality) and `docs/test-cases.md` |
| Git workflow (branches, pull requests, merges) | One branch and pull request per stage of work |
| Build and release (APK) with versioning | Tagged releases, starting at `v0.1.0` |
| Technical documentation | PRD, README, `docs/api.md`, changelog, decision notes |

Authentication and token handling are not covered in Phases 1 and 2. They belong with a real backend (see section 8).

---

## 10. Non-functional requirements

- **Offline first:** every Phase 1 and 2 feature works without a network.
- **Platform:** Android, tested on the emulator.
- **Language:** English interface by default. Strings are kept in one place so another language can be added later.
- **Accessibility:** touch targets of at least 44 dp, text contrast of at least 4.5:1, labels on icon-only buttons.
- **Quality:** unit tests for the model and repository, widget tests for the main screens, and a manual test case list in `docs/test-cases.md`.

---

## 11. Definition of done

**Phase 1:** the author can record real applications for one week without data loss or crashes. All Phase 1 acceptance criteria pass, including back up and restore against the mock API with loading and error states tested. An installable APK is published as `v0.1.0`, with the README, changelog, and test cases up to date.

**Phase 2:** each story is delivered on its own branch and release (`v0.2.0` and later) with its tests and documentation.

---

## 12. Open questions

1. State management: Provider or Riverpod (to be recorded as a decision note).
2. Local storage package: SQLite-based (`sqflite` or `drift`), to be chosen after checking which packages are actively maintained.
3. Mock server choice (json-server, Mockoon, or a small custom server) and HTTP package (`http` or `dio`).
4. Whether stage colors alone are enough to tell Accepted from Rejected in lists.
