import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/symptoms.dart';

class SymptomDialog extends StatefulWidget {
  @override
  _SymptomDialogState createState() => _SymptomDialogState();
}

class _SymptomDialogState extends State<SymptomDialog> {
  String _selectedType = 'Cramps';
  int _severity = 3;
  final _notesController = TextEditingController();

  final List<String> _symptomTypes = [
    'Cramps',
    'Headache',
    'Bloating',
    'Fatigue',
    'Mood Swings',
    'Breast Tenderness',
    'Acne',
    'Back Pain',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Log Symptom'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: _symptomTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedType = value!);
              },
              decoration: InputDecoration(
                labelText: 'Symptom Type',
              ),
            ),
            SizedBox(height: 16),
            Text('Severity'),
            Slider(
              value: _severity.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: _severity.toString(),
              onChanged: (value) {
                setState(() => _severity = value.round());
              },
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Notes (optional)',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final symptom = Symptom(
              date: DateTime.now(),
              type: _selectedType,
              severity: _severity,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
            );
            Navigator.pop(context, symptom);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}