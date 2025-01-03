import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/period_data.dart';
import 'package:quamin_health_module/health_module/health_services/cycle_tracking_services/period_service.dart';

class CalendarStrip extends StatefulWidget {
  const CalendarStrip({super.key});

  @override
  _CalendarStripState createState() => _CalendarStripState();
}

class _CalendarStripState extends State<CalendarStrip> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  late List<DateTime> _availableMonths;
  final PeriodService _periodService = PeriodService();
  PeriodData? _periodData;
  Map<DateTime, List<String>> _symptoms = {};
  final ScrollController _monthScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
    _availableMonths = _generateMonthsList();
    _loadPeriodData();
    _scrollToCurrentMonth();
  }

  void _scrollToCurrentMonth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentMonthIndex = _availableMonths.indexWhere(
        (date) => date.year == DateTime.now().year && date.month == DateTime.now().month
      );
      if (currentMonthIndex != -1) {
        _monthScrollController.animateTo(
          currentMonthIndex * 100.0, // Approximate width of month item
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _loadPeriodData() async {
    final data = await _periodService.getPeriodData();
    if (data != null) {
      final Map<DateTime, List<String>> symptomsMap = {};
      for (var symptom in data.symptoms) {
        final date = DateTime(symptom.date.year, symptom.date.month, symptom.date.day);
        symptomsMap[date] ??= [];
        symptomsMap[date]!.add(symptom.type);
      }
      setState(() {
        _periodData = data;
        _symptoms = symptomsMap;
      });
    }
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

  void _showSymptomDetails(BuildContext context, DateTime date) {
    final symptoms = _symptoms[date] ?? [];
    if (symptoms.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(DateFormat('MMM d, yyyy').format(date)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Symptoms recorded:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...symptoms.map((symptom) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8),
                  SizedBox(width: 8),
                  Text(symptom),
                ],
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Current Month Display
        Padding(
          padding: EdgeInsets.symmetric(vertical: sh * 0.015),
          child: Text(
            DateFormat('MMMM yyyy').format(_currentMonth),
            style: TextStyle(
              fontSize: sw * 0.056,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Month Selection Strip
        Container(
          height: sh * 0.067,
          child: ListView.builder(
            controller: _monthScrollController,
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
                  margin: EdgeInsets.symmetric(horizontal: sw * 0.011),
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.034,
                    vertical: sh * 0.012,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF636ae8) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(sw * 0.056),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: Color(0xFF636ae8).withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ] : null,
                  ),
                  child: Text(
                    DateFormat('MMM yyyy').format(month),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: sw * 0.034,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: sh * 0.015),

        // Days Grid
        Container(
          height: sh * 0.1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day,
            itemBuilder: (context, index) {
              final day = DateTime(_currentMonth.year, _currentMonth.month, index + 1);
              final isSelected = _selectedDate.year == day.year &&
                  _selectedDate.month == day.month &&
                  _selectedDate.day == day.day;
              final isPeriodDay = _periodData?.isInPeriod(day) ?? false;
              final hasSymptoms = _symptoms.containsKey(day);

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedDate = day);
                  if (hasSymptoms) {
                    _showSymptomDetails(context, day);
                  }
                },
                child: Container(
                  width: sw * 0.141,
                  margin: EdgeInsets.symmetric(horizontal: sw * 0.011),
                  decoration: BoxDecoration(
                    color: isPeriodDay
                        ? Color(0xFFFFE6E6)
                        : isSelected
                            ? Color(0xFF636ae8)
                            : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(sw * 0.07),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Color(0xFF636ae8).withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('E').format(day)[0],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black54,
                                fontSize: sw * 0.034,
                              ),
                            ),
                            SizedBox(height: sh * 0.005),
                            Text(
                              day.day.toString(),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: sw * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (hasSymptoms)
                        Positioned(
                          top: sh * 0.008,
                          right: sw * 0.017,
                          child: Container(
                            width: sw * 0.022,
                            height: sw * 0.022,
                            decoration: BoxDecoration(
                              color: Color(0xFF9f85ec),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _monthScrollController.dispose();
    super.dispose();
  }
}