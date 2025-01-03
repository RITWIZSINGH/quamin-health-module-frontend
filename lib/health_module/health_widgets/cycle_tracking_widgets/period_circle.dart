import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/period_data.dart';
import 'package:quamin_health_module/health_module/health_services/cycle_tracking_services/period_service.dart';
import 'edit_period_dialog.dart';

class PeriodCircle extends StatefulWidget {
  const PeriodCircle({super.key});

  @override
  State<PeriodCircle> createState() => _PeriodCircleState();
}

class _PeriodCircleState extends State<PeriodCircle> {
  final PeriodService _periodService = PeriodService();
  PeriodData? _periodData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPeriodData();
  }

  Future<void> _loadPeriodData() async {
    setState(() => _isLoading = true);
    final data = await _periodService.getPeriodData();
    setState(() {
      _periodData = data;
      _isLoading = false;
    });
    
    // If no data exists, show the edit dialog immediately
    if (data == null) {
      _editPeriodDates();
    }
  }

  Future<void> _editPeriodDates() async {
    final result = await showDialog<PeriodData>(
      context: context,
      barrierDismissible: _periodData != null, // Only allow dismissal if data exists
      builder: (context) => EditPeriodDialog(currentData: _periodData),
    );

    if (result != null) {
      await _periodService.savePeriodData(result);
      await _loadPeriodData();
    } else if (_periodData == null) {
      // If user somehow dismisses the dialog without entering data when no data exists,
      // show it again
      _editPeriodDates();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF878CED),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Period in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${_periodData?.daysUntilNextPeriod ?? 0} days',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _periodData != null 
                ? _periodService.getFertilityStatus(_periodData!)
                : 'No data available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _editPeriodDates,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF878CED),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
              child: Text(
                'Edit period dates',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}