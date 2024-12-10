import 'package:flutter/material.dart';

class SleepSchedule extends StatefulWidget {
  const SleepSchedule({super.key});

  @override
  _SleepScheduleState createState() => _SleepScheduleState();
}

class _SleepScheduleState extends State<SleepSchedule> {
  TimeOfDay _bedTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _wakeUpTime = const TimeOfDay(hour: 7, minute: 30);

  // Method to show time picker and update time
  Future<void> _selectTime(BuildContext context, bool isBedTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isBedTime ? _bedTime : _wakeUpTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isBedTime) {
          _bedTime = picked;
        } else {
          _wakeUpTime = picked;
        }
      });
    }
  }

  // Convert TimeOfDay to formatted string
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '${hour == 0 ? 12 : hour}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Set your schedule',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Show bottom sheet with edit options
                _showEditBottomSheet(context);
              },
              child: const Text('Edit'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTimeCard(
                'Bedtime',
                _formatTime(_bedTime),
                _bedTime.period == DayPeriod.am ? 'am' : 'pm',
                const Color(0XFFEA916E),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTimeCard(
                'Wake up',
                _formatTime(_wakeUpTime),
                _wakeUpTime.period == DayPeriod.am ? 'am' : 'pm',
                const Color(0XFF7F55E0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Bottom sheet for editing times
  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Sleep Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Bedtime'),
                // subtitle: Text(_formatTime(_bedTime) +
                //     ' ' +
                //     (_bedTime.period == DayPeriod.am ? 'am' : 'pm')),
                trailing: const Icon(Icons.edit),
                onTap: () => _selectTime(context, true),
              ),
              ListTile(
                title: const Text('Wake up time'),
                // subtitle: Text(_formatTime(_wakeUpTime) + ' ' +
                //     (_wakeUpTime.period == DayPeriod.am ? 'am' : 'pm')),
                trailing: const Icon(Icons.edit),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Color(0xff636ae8)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeCard(String label, String time, String period, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                label == 'Bedtime' ? Icons.bedtime : Icons.wb_sunny,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                period,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
