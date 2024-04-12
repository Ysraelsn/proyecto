class User {
  final int id;
  final String name;
  final String email;
  final DateTime created_at;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.created_at});
  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return User(
        id: id == null
            ? 0
            : id, // Si id es nulo, asigna 0 (o cualquier otro valor predeterminado)
        name: json['name'],
        email: json['email'],
        created_at: DateTime.parse(json['created_at']));
  }
}
