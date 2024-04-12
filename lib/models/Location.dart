class Location {
  final int id;
  final String name;
  final String address;
  final int capacity;
  final double price;
  final String imageURL;

  const Location({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.price,
    required this.imageURL,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      capacity: json['capacity'],
      price: json['price'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'capacity': capacity,
      'price': price,
      'imageURL': imageURL,
    };
  }
}
