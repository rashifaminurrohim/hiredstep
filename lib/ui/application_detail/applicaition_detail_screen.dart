import 'package:flutter/material.dart';
import 'package:hiredstep/ui/application_detail/widgets/history_timeline.dart';
import 'package:hiredstep/ui/core/widgets/status_badge.dart';

import '../../domain/models/application.dart';

class ApplicationDetailScreen extends StatelessWidget {
  const ApplicationDetailScreen({required this.application, super.key});

  final Application application;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final notes = application.notes;

    return Scaffold(
      appBar: AppBar(title: const Text('Application')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(application.company, style: textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text(application.position, style: textTheme.headlineMedium),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusBadge(status: application.status),
          ),
          const SizedBox(height: 24),
          Text('History', style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.all(16),
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
                    Text('Notes', style: textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(notes),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
