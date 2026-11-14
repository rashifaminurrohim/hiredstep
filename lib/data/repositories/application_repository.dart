import 'package:hiredstep/domain/models/application.dart';

abstract class ApplicationRepository {
  Future<List<Application>> getApplications();

  Future<Application?> getApplication(String id);

  Future<void> add(Application application);
}
