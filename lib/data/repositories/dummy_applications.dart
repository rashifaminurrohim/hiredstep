import 'package:hiredstep/config/default_statuses.dart';
import 'package:hiredstep/domain/models/application.dart';
import 'package:hiredstep/domain/models/history_entry.dart';
import 'package:hiredstep/domain/models/status.dart';

// Temporary data for stage 2. Replaced by a repository in stage 3.
Status _status(String id) {
  return defaultStatuses.firstWhere((status) => status.id == id);
}

HistoryEntry _entry(String id, String statusId, DateTime date) {
  return HistoryEntry(
    id: id,
    status: _status(statusId),
    date: date,
    createdAt: date,
  );
}

final List<Application> dummyApplications = [
  Application(
    id: '1',
    company: 'Company A',
    position: 'Flutter Mobile Intern',
    status: _status('technical-test'),
    appliedAt: DateTime(2026, 9, 17),
    notes: 'Online technical test. Prepare Flutter and Dart basics.',
    history: [
      _entry('h1', 'applied', DateTime(2026, 9, 17)),
      _entry('h2', 'interview', DateTime(2026, 9, 24)),
      _entry('h3', 'technical-test', DateTime(2026, 11, 5)),
    ],
  ),
  Application(
    id: '2',
    company: 'Company B',
    position: 'QA Intern',
    status: _status('applied'),
    appliedAt: DateTime(2026, 9, 24),
    history: [_entry('h4', 'applied', DateTime(2026, 9, 24))],
  ),
  Application(
    id: '3',
    company: 'Company C',
    position: 'Android Developer Intern',
    status: _status('interview'),
    appliedAt: DateTime(2026, 9, 30),
    history: [
      _entry('h5', 'applied', DateTime(2026, 9, 30)),
      _entry('h6', 'interview', DateTime(2026, 10, 12)),
    ],
  ),
  Application(
    id: '4',
    company: 'Company D',
    position: 'Frontend Intern',
    status: _status('rejected'),
    appliedAt: DateTime(2026, 10, 2),
    history: [
      _entry('h7', 'applied', DateTime(2026, 10, 2)),
      _entry('h8', 'rejected', DateTime(2026, 10, 20)),
    ],
  ),
  Application(
    id: '5',
    company: 'Company E',
    position: 'UI Intern',
    status: _status('saved'),
    history: [_entry('h9', 'saved', DateTime(2026, 9, 28))],
  ),
];
