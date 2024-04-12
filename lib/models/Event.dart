class Event {
  final int id;
  final String customerName;
  final String locationName;
  final String date;
  final String eventType;

  Event({
    required this.id,
    required this.customerName,
    required this.locationName,
    required this.date,
    required this.eventType,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      customerName: json['customer_name'],
      locationName: json['location_name'],
      date: json['date'],
      eventType: json['event_type'],
    );
  }
}
