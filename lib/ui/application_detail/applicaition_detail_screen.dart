import 'package:flutter/material.dart';
import 'package:hiredstep/ui/application_detail/view_models/application_detail.view.model.dart';
import 'package:hiredstep/ui/application_detail/widgets/history_timeline.dart';
import 'package:hiredstep/ui/core/widgets/empty_state.dart';
import 'package:hiredstep/ui/core/widgets/status_badge.dart';
import 'package:provider/provider.dart';

import '../../domain/models/application.dart';

class ApplicationDetailScreen extends StatelessWidget {
  const ApplicationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ApplicationDetailViewModel>();
    final application = viewModel.application;
    final errorMessage = viewModel.errorMessage;

    return Scaffold(
      appBar: AppBar(title: const Text('Application')),
      body: _buildBody(viewModel, application, errorMessage),
    );
  }

  Widget _buildBody(
    ApplicationDetailViewModel viewModel,
    Application? application,
    String? errorMessage,
  ) {
    if (errorMessage != null) {
      return EmptyState(
        message: errorMessage,
        actionLabel: 'Retry',
        onAction: viewModel.load,
      );
    }
    if (application == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return _DetailContent(application: application);
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.application});

  final Application application;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final notes = application.notes;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(application.company, style: textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(application.position, style: textTheme.bodyLarge),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: StatusBadge(status: application.status),
        ),
        const SizedBox(height: 24),
        Text('History', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: HistoryTimeline(entries: application.history),
          ),
        ),
        if (notes != null) ...[
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notes', style: textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(notes),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
