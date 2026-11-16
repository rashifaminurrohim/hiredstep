import 'package:flutter/material.dart';
import 'package:hiredstep/ui/application_form/view_models/application_form_view_model.dart';
import 'package:provider/provider.dart';

import '../../domain/models/stage.dart';
import '../../utils/date_format.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final viewModel = context.read<ApplicationFormViewModel>();
    final picked = await showDatePicker(
      context: context,
      initialDate: viewModel.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      viewModel.selectDate(picked);
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await context.read<ApplicationFormViewModel>().save(
      company: _companyController.text,
      position: _positionController.text,
      notes: _notesController.text,
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ApplicationFormViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add application')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _companyController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Company *',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  viewModel.validateRequired(value, 'Company is required'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _positionController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Position *',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  viewModel.validateRequired(value, 'Position is required'),
            ),
            const SizedBox(height: 16),
            Text('Stage', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<Stage>(
              segments: const [
                ButtonSegment(value: Stage.saved, label: Text('Saved')),
                ButtonSegment(value: Stage.applied, label: Text('Applied')),
              ],
              selected: {viewModel.stage},
              onSelectionChanged: (selection) {
                viewModel.selectStage(selection.first);
              },
            ),
            if (viewModel.showsDate) ...[
              const SizedBox(height: 16),
              TextFormField(
                key: ValueKey(viewModel.date),
                initialValue: formatDate(viewModel.date),
                readOnly: true,
                onTap: _pickDate,
                decoration: const InputDecoration(
                  labelText: 'Application date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: viewModel.isSaving ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
