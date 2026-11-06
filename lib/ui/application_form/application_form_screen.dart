import 'package:flutter/material.dart';
import 'package:hiredstep/domain/models/history_entry.dart';
import 'package:hiredstep/utils/id_generator.dart';

import '../../config/default_statuses.dart';
import '../../domain/models/application.dart';
import '../../domain/models/stage.dart';
import '../../domain/models/status.dart';
import '../../utils/date_format.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key});

  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _notesController = TextEditingController();

  Stage _stage = Stage.applied;
  DateTime _date = DateTime.now();

  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  Status _statusFor(Stage stage) {
    return defaultStatuses.firstWhere((status) => status.stage == stage);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      setState(() => _date = picked);
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final status = _statusFor(_stage);
    final notes = _notesController.text;
    final application = Application(
      id: generateId(),
      company: _companyController.text,
      position: _positionController.text,
      status: status,
      appliedAt: _stage == Stage.applied ? _date : null,
      notes: notes.isEmpty ? null : notes,
      history: [
        HistoryEntry(
          id: generateId(),
          status: status,
          date: _date,
          createdAt: DateTime.now(),
        ),
      ],
    );
    Navigator.of(context).pop(application);
  }

  @override
  Widget build(BuildContext context) {
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
                  _validateRequired(value, 'Company is required'),
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
                  _validateRequired(value, 'Position is required'),
            ),
            const SizedBox(height: 16),
            Text('Stage', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<Stage>(
              segments: const [
                ButtonSegment(value: Stage.saved, label: Text('Saved')),
                ButtonSegment(value: Stage.applied, label: Text('Applied')),
              ],
              selected: {_stage},
              onSelectionChanged: (selection) {
                setState(() => _stage = selection.first);
              },
            ),
            if (_stage == Stage.applied) ...[
              const SizedBox(height: 16),
              TextFormField(
                key: ValueKey(_date),
                initialValue: formatDate(_date),
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
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _save,
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
