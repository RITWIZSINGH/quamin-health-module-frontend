class Symptom {
  final DateTime date;
  final String type;
  final int severity; // 1-5
  final String? notes;

  Symptom({
    required this.date,
    required this.type,
    required this.severity,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'type': type,
      'severity': severity,
      'notes': notes,
    };
  }

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      date: DateTime.parse(json['date']),
      type: json['type'],
      severity: json['severity'],
      notes: json['notes'],
    );
  }
}