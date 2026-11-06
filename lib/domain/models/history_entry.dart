import 'package:hiredstep/domain/models/status.dart';

class HistoryEntry {
  const HistoryEntry({
    required this.id,
    required this.status,
    required this.date,
    required this.createdAt,
    this.note,
  });

  final String id;
  final Status status;

  // Editable by the user, default will be today
  final DateTime date;

  // Recorded automatically, never shown in the interface
  final DateTime createdAt;
  final String? note;
}
