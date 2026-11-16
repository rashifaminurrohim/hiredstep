import 'package:flutter/foundation.dart';
import 'package:hiredstep/data/repositories/application_repository.dart';

import '../../../domain/models/application.dart';

class ApplicationListViewModel extends ChangeNotifier {
  ApplicationListViewModel({required this._repository});

  final ApplicationRepository _repository;

  List<Application> _applications = const [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Application> get applications => _applications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final items = await _repository.getApplications();
      _applications = [...items]..sort(_byRecentActivity);
    } on Exception {
      _errorMessage = 'Could not load applications.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static int _byRecentActivity(Application a, Application b) {
    final aTime = a.lastActivityAt;
    final bTime = b.lastActivityAt;
    if (aTime == null && bTime == null) {
      return 0;
    }
    if (aTime == null) {
      return 1;
    }
    if (bTime == null) {
      return -1;
    }
    return bTime.compareTo(aTime);
  }
}
