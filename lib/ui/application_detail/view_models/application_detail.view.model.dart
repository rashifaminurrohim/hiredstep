import 'package:flutter/foundation.dart';

import '../../../data/repositories/application_repository.dart';
import '../../../domain/models/application.dart';

class ApplicationDetailViewModel extends ChangeNotifier {
  ApplicationDetailViewModel({
    required this._repository,
    required this._applicationId,
  });

  final ApplicationRepository _repository;
  final String _applicationId;

  Application? _application;
  bool _isLoading = false;
  String? _errorMessage;

  Application? get application => _application;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final application = await _repository.getApplication(_applicationId);
      if (application == null) {
        _errorMessage = 'Application not found.';
      } else {
        _application = application;
      }
    } on Exception {
      _errorMessage = 'Could not load the application.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
