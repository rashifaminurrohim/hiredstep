import 'package:hiredstep/domain/models/history_entry.dart';
import 'package:hiredstep/domain/models/status.dart';

class Application {
  const Application({
    required this.id,
    required this.company,
    required this.position,
    required this.status,
    this.appliedAt,
    this.notes,
    this.history = const [],
  });

  final String id;
  final String company;
  final String position;
  final Status status;
  final DateTime? appliedAt;
  final String? notes;
  final List<HistoryEntry> history;
}
