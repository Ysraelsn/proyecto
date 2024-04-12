class Company {
  final int id;
  final String name;
  final String description;
  final String contact;
  final String type;

  const Company({
    required this.id,
    required this.name,
    required this.description,
    required this.contact,
    required this.type,
  });
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      contact: json['contact'],
      type: json['type'],
    );
  }
}
