import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/period_data.dart';

class EditPeriodDialog extends StatefulWidget {
  final PeriodData? currentData;

  const EditPeriodDialog({super.key, this.currentData});

  @override
  State<EditPeriodDialog> createState() => _EditPeriodDialogState();
}

class _EditPeriodDialogState extends State<EditPeriodDialog> {
  late DateTime _startDate;
  DateTime? _endDate;
  late int _cycleLength;
  late int _periodLength;

  @override
  void initState() {
    super.initState();
    _startDate = widget.currentData?.startDate ?? DateTime.now();
    _endDate = widget.currentData?.endDate;
    _cycleLength = widget.currentData?.cycleLength ?? 28;
    _periodLength = widget.currentData?.periodLength ?? 5;
  }

  bool get _isValid {
    if (_endDate != null && _endDate!.isBefore(_startDate)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.currentData != null, // Only allow back if editing existing data
      child: AlertDialog(
        title: Text(widget.currentData != null ? 'Edit Period Dates' : 'Set Your Period Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.currentData == null)
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Please enter your period information to get started.',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              _buildDatePicker(
                label: 'Start Date',
                value: _startDate,
                onChanged: (date) => setState(() => _startDate = date),
              ),
              SizedBox(height: 16),
              _buildDatePicker(
                label: 'End Date',
                value: _endDate,
                onChanged: (date) => setState(() => _endDate = date),
                optional: true,
              ),
              SizedBox(height: 16),
              _buildNumberPicker(
                label: 'Cycle Length (days)',
                value: _cycleLength,
                onChanged: (value) => setState(() => _cycleLength = value),
                min: 21,
                max: 35,
              ),
              SizedBox(height: 16),
              _buildNumberPicker(
                label: 'Period Length (days)',
                value: _periodLength,
                onChanged: (value) => setState(() => _periodLength = value),
                min: 3,
                max: 7,
              ),
            ],
          ),
        ),
        actions: [
          if (widget.currentData != null)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ElevatedButton(
            onPressed: _isValid
                ? () {
                    final newData = PeriodData(
                      startDate: _startDate,
                      endDate: _endDate,
                      cycleLength: _cycleLength,
                      periodLength: _periodLength,
                      symptoms: widget.currentData?.symptoms ?? [],
                    );
                    Navigator.pop(context, newData);
                  }
                : null,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? value,
    required ValueChanged<DateTime> onChanged,
    bool optional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (date != null) {
              onChanged(date);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value != null
                    ? '${value.year}-${value.month}-${value.day}'
                    : optional
                        ? 'Optional'
                        : 'Select date'),
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberPicker({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
    required int min,
    required int max,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
            Text('$value'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: value < max ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}