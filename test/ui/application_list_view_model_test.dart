import 'package:flutter_test/flutter_test.dart';
import 'package:hiredstep/data/repositories/dummy_applications.dart';
import 'package:hiredstep/data/repositories/in_memory_application_repository.dart';
import 'package:hiredstep/ui/application_list/view_models/application_list_view_model.dart';

void main() {
  test('sorts applications by most recent activity', () async {
    final viewModel = ApplicationListViewModel(
      repository: InMemoryApplicationRepository(seed: dummyApplications),
    );

    await viewModel.load();

    expect(viewModel.applications.first.company, 'Company A');
    expect(viewModel.applications.last.company, 'Company B');
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.errorMessage, isNull);
  });

  test('is empty when the repository has no data', () async {
    final viewModel = ApplicationListViewModel(
      repository: InMemoryApplicationRepository(seed: []),
    );

    await viewModel.load();

    expect(viewModel.applications, isEmpty);
  });
}
