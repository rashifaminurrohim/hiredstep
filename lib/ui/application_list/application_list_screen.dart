import 'package:flutter/material.dart';
import 'package:hiredstep/ui/application_list/widgets/application_card.dart';
import 'package:hiredstep/ui/core/widgets/empty_state.dart';

import '../../domain/models/application.dart';

class ApplicationListScreen extends StatelessWidget {
  const ApplicationListScreen({required this.applications, super.key});

  final List<Application> applications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Applications')),
      body: applications.isEmpty
          ? EmptyState(
              message: 'No applications yet.',
              actionLabel: 'Add application',
              // Navigationg to the form comes in stage 2.
              onAction: () {},
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: applications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return ApplicationCard(application: applications[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Application'),
      ),
    );
  }
}
