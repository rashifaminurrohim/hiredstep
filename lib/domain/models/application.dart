import 'package:hiredstep/domain/models/status.dart';

class Application {
  const Application({
    required this.id,
    required this.company,
    required this.position,
    required this.status,
    required this.appliedAt,
    required this.notes,
  });

  final String id;
  final String company;
  final String position;
  final Status status;
  final DateTime? appliedAt;
  final String? notes;
}
