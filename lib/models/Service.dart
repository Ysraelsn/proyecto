class Service {
  final int id;
  final String name;
  final String description;
  final double price;

  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }
}
