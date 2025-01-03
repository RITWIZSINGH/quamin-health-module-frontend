import 'package:flutter/material.dart';

class InsightsDialog extends StatelessWidget {
  final List<String> insights;

  const InsightsDialog({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Your Daily Insights'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: insights.map((insight) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Expanded(child: Text(insight)),
              ],
            ),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}