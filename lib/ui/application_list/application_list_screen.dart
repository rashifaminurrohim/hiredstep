import 'package:flutter/material.dart';
import 'package:hiredstep/data/repositories/application_repository.dart';
import 'package:hiredstep/ui/application_detail/applicaition_detail_screen.dart';
import 'package:hiredstep/ui/application_detail/view_models/application_detail.view.model.dart';
import 'package:hiredstep/ui/application_form/view_models/application_form_view_model.dart';
import 'package:hiredstep/ui/application_list/view_models/application_list_view_model.dart';
import 'package:hiredstep/ui/application_list/widgets/application_card.dart';
import 'package:hiredstep/ui/core/widgets/empty_state.dart';
import 'package:provider/provider.dart';

import '../../domain/models/application.dart';
import '../application_form/application_form_screen.dart';

class ApplicationListScreen extends StatelessWidget {
  const ApplicationListScreen({super.key});

  Future<void> _openForm(BuildContext context) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ApplicationFormViewModel(
            repository: context.read<ApplicationRepository>(),
          ),
          child: const ApplicationFormScreen(),
        ),
      ),
    );
    if (saved == true && context.mounted) {
      await context.read<ApplicationListViewModel>().load();
    }
  }

  void _openDetail(BuildContext context, Application application) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ApplicationDetailViewModel(
            repository: context.read<ApplicationRepository>(),
            applicationId: application.id,
          )..load(),
          child: const ApplicationDetailScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ApplicationListViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Applications')),
      body: _buildBody(context, viewModel),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Application'),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ApplicationListViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.applications.isEmpty) {
      return EmptyState(
        message: 'No applications yet.',
        actionLabel: 'Add application',
        onAction: () => _openForm(context),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.applications.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final application = viewModel.applications[index];
        return ApplicationCard(
          application: application,
          onTap: () => _openDetail(context, application),
        );
      },
    );
  }
}
