import 'package:hiredstep/config/default_statuses.dart';
import 'package:hiredstep/domain/models/application.dart';
import 'package:hiredstep/domain/models/status.dart';

// Temporary data for stage 1. Replaced by a repository in stage 3.
Status _status(String id) {
  return defaultStatuses.firstWhere((status) => status.id == id);
}

final List<Application> dummyApplications = [
  Application(
    id: '1',
    company: 'Company A',
    position: 'Flutter Mobile Intern',
    status: _status('technical-test'),
    appliedAt: DateTime(2026, 9, 17),
  ),
  Application(
    id: '2',
    company: 'Company B',
    position: 'QA Intern',
    status: _status('applied'),
    appliedAt: DateTime(2026, 9, 24),
  ),
  Application(
    id: '3',
    company: 'Company C',
    position: 'Android Developer Intern',
    status: _status('interview'),
    appliedAt: DateTime(2026, 9, 30),
  ),
  Application(
    id: '4',
    company: 'Company D',
    position: 'Frontend Intern',
    status: _status('rejected'),
    appliedAt: DateTime(2026, 10, 2),
  ),
  Application(
    id: '5',
    company: 'Company E',
    position: 'UI Intern',
    status: _status('saved'),
  ),
];
