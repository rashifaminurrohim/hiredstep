import 'package:hiredstep/data/repositories/application_repository.dart';

import '../../domain/models/application.dart';

class InMemoryApplicationRepository implements ApplicationRepository {
  InMemoryApplicationRepository({List<Application> seed = const []})
    : _applications = [...seed];

  final List<Application> _applications;

  @override
  Future<List<Application>> getApplications() async {
    return List.unmodifiable(_applications);
  }

  @override
  Future<Application?> getApplication(String id) async {
    for (final application in _applications) {
      if (application.id == id) {
        return application;
      }
    }
    return null;
  }

  @override
  Future<void> add(Application application) async {
    _applications.add(application);
  }
}
