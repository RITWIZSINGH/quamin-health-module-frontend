// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class CalorieSummary extends StatelessWidget {
  const CalorieSummary({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: sh / 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text(
                'You have consumed',
                style: TextStyle(fontSize: 18),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 24),
                  children: [
                    TextSpan(
                      text: '960 kcal ',
                      style: TextStyle(
                        color: Color(0xff878ced),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: 'today',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
