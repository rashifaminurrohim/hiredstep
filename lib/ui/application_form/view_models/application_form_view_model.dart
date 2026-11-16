import 'package:flutter/foundation.dart';
import 'package:hiredstep/config/default_statuses.dart';
import 'package:hiredstep/data/repositories/application_repository.dart';
import 'package:hiredstep/utils/id_generator.dart';

import '../../../domain/models/application.dart';
import '../../../domain/models/history_entry.dart';
import '../../../domain/models/stage.dart';

class ApplicationFormViewModel extends ChangeNotifier {
  ApplicationFormViewModel({required this._repository});

  final ApplicationRepository _repository;

  Stage _stage = Stage.applied;
  DateTime _date = DateTime.now();
  bool _isSaving = false;

  Stage get stage => _stage;
  DateTime get date => _date;
  bool get isSaving => _isSaving;
  bool get showsDate => _stage == Stage.applied;

  void selectStage(Stage stage) {
    _stage = stage;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  String? validateRequired(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  Future<void> save({
    required String company,
    required String position,
    String? notes,
  }) async {
    _isSaving = true;
    notifyListeners();

    try {
      final status = defaultStatuses.firstWhere(
        (status) => status.stage == _stage,
      );
      final trimmedNotes = notes?.trim();
      final application = Application(
        id: generateId(),
        company: company.trim(),
        position: position.trim(),
        status: status,
        appliedAt: _stage == Stage.applied ? _date : null,
        notes: (trimmedNotes == null || trimmedNotes.isEmpty)
            ? null
            : trimmedNotes,
        history: [
          HistoryEntry(
            id: generateId(),
            status: status,
            date: _date,
            createdAt: DateTime.now(),
          ),
        ],
      );
      await _repository.add(application);
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
