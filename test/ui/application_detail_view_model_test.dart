import 'package:flutter_test/flutter_test.dart';
import 'package:hiredstep/data/repositories/dummy_applications.dart';
import 'package:hiredstep/data/repositories/in_memory_application_repository.dart';
import 'package:hiredstep/ui/application_detail/view_models/application_detail.view.model.dart';

void main() {
  test('loads an application by id', () async {
    final viewModel = ApplicationDetailViewModel(
      repository: InMemoryApplicationRepository(seed: dummyApplications),
      applicationId: '1',
    );

    await viewModel.load();

    expect(viewModel.application?.company, 'Company A');
    expect(viewModel.errorMessage, isNull);
  });

  test('reports an error when the application does not exist', () async {
    final viewModel = ApplicationDetailViewModel(
      repository: InMemoryApplicationRepository(seed: dummyApplications),
      applicationId: 'missing',
    );

    await viewModel.load();

    expect(viewModel.application, isNull);
    expect(viewModel.errorMessage, 'Application not found.');
  });
}
