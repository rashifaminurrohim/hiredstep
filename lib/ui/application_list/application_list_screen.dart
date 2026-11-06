import 'package:flutter/material.dart';
import 'package:hiredstep/ui/application_list/widgets/application_card.dart';
import 'package:hiredstep/ui/core/widgets/empty_state.dart';

import '../../domain/models/application.dart';
import '../application_form/application_form_screen.dart';

class ApplicationListScreen extends StatefulWidget {
  const ApplicationListScreen({required this.applications, super.key});

  // Initial data. Replaced by a view model in stage 3.
  final List<Application> applications;

  @override
  State<ApplicationListScreen> createState() => _ApplicationListScreenState();
}

class _ApplicationListScreenState extends State<ApplicationListScreen> {
  late final List<Application> _applications = [...widget.applications];

  Future<void> _openForm() async {
    final created = await Navigator.of(context).push<Application>(
      MaterialPageRoute(builder: (_) => const ApplicationFormScreen()),
    );
    if (created == null || !mounted) {
      return;
    }
    setState(() => _applications.insert(0, created));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Applications')),
      body: widget.applications.isEmpty
          ? EmptyState(
              message: 'No applications yet.',
              actionLabel: 'Add application',
              onAction: _openForm,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _applications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return ApplicationCard(application: _applications[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('Add Application'),
      ),
    );
  }
}
