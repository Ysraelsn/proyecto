class Planification {
  final int? id;
  final String? eventType;
  final String? companyName;
  final DateTime? hireDate;
  final String? status;
  final double? budget;
  final String? notes;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? attendance;
  final String? feedback;
  final DateTime? completionDate;

  const Planification({
    this.id,
    this.eventType,
    this.companyName,
    this.hireDate,
    this.status,
    this.budget,
    this.notes,
    this.startDate,
    this.endDate,
    this.attendance,
    this.feedback,
    this.completionDate,
  });

  factory Planification.fromJson(Map<String, dynamic> json) {
    return Planification(
      id: json['id'],
      eventType: json['event_type'],
      companyName: json['company_name'],
      hireDate:
          json['hire_date'] != null ? DateTime.parse(json['hire_date']) : null,
      status: json['status'],
      budget: json['budget_used']?.toDouble(),
      notes: json['notes'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      attendance: json['attendance'],
      feedback: json['feedback'],
      completionDate: json['completion_date'] != null
          ? DateTime.parse(json['completion_date'])
          : null,
    );
  }
}
