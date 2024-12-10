import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarStrip extends StatefulWidget {
  const CalendarStrip({super.key});

  @override
  _CalendarStripState createState() => _CalendarStripState();
}

class _CalendarStripState extends State<CalendarStrip> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  late List<DateTime> _availableMonths;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();

    // Generate a list of months (current year + previous and next year)
    _availableMonths = _generateMonthsList();
  }

  List<DateTime> _generateMonthsList() {
    List<DateTime> months = [];
    final now = DateTime.now();

    // Previous year's months
    for (int month = 1; month <= 12; month++) {
      months.add(DateTime(now.year - 1, month));
    }

    // Current year's months
    for (int month = 1; month <= 12; month++) {
      months.add(DateTime(now.year, month));
    }

    // Next year's months
    for (int month = 1; month <= 12; month++) {
      months.add(DateTime(now.year + 1, month));
    }

    return months;
  }

  void _changeMonth(bool isNext) {
    setState(() {
      _currentMonth = DateTime(
          _currentMonth.year, _currentMonth.month + (isNext ? 1 : -1), 1);
    });
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    return List.generate(
        lastDay.day,
        (index) =>
            DateTime(_currentMonth.year, _currentMonth.month, index + 1));
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    print(sw);
    double sh = MediaQuery.of(context).size.height;
    print(sh);
    return Column(
      children: [
        // Current Month Display
        Padding(
          padding: EdgeInsets.symmetric(vertical: sw / 44.25),
          child: Text(
            DateFormat('MMMM yyyy').format(_currentMonth),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Month Selection Strip
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availableMonths.length,
            itemBuilder: (context, index) {
              final month = _availableMonths[index];
              final isSelected = month.year == _currentMonth.year &&
                  month.month == _currentMonth.month;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMonth = month;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: sw / 88.5),
                  padding: EdgeInsets.symmetric(
                      horizontal: sw / 29.5, vertical: sw / 29.5),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF636ae8)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    DateFormat('MMM yyyy').format(month),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        // Day Selection Row
        Row(
          children: [
            // Month navigation button (previous)
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _changeMonth(false),
            ),

            // Calendar strip
            Expanded(
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _getDaysInMonth().length,
                  itemBuilder: (context, index) {
                    final day = _getDaysInMonth()[index];
                    final isSelected = _selectedDate.day == day.day &&
                        _selectedDate.month == day.month &&
                        _selectedDate.year == day.year;

                    return _buildDay(
                        weekday: DateFormat('E').format(day)[0],
                        date: DateFormat('dd').format(day),
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedDate = day;
                          });
                        });
                  },
                ),
              ),
            ),

            // Month navigation button (next)
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _changeMonth(true),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDay({
    required String weekday,
    required String date,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF636ae8) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
