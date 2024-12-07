import 'package:flutter/material.dart';

class CalendarStrip extends StatelessWidget {
  const CalendarStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal, 
        children: [
          _buildDay('M', '06', false),
          _buildDay('T', '07', false),
          _buildDay('W', '08', false),
          _buildDay('T', '09', false),
          _buildDay('F', '10', false),
          _buildDay('S', '11', true),
          _buildDay('S', '12', false),
        ],
      ),
    );
  }

  Widget _buildDay(String weekday, String date, bool isSelected) {
    return Container(
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF878CED) : Colors.transparent,
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
    );
  }
}
