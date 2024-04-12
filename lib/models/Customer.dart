class Customer {
  final int id;
  final String first_name;
  final String second_name;
  final String surname;
  final String second_surname;
  final String email;
  final String phone_number;
  final int age;
  final int budget;

  const Customer(
      {required this.id,
      required this.first_name,
      required this.second_name,
      required this.surname,
      required this.second_surname,
      required this.email,
      required this.phone_number,
      required this.age,
      required this.budget});
  factory Customer.fromJson(Map json) {
    return Customer(
      id: json['id'],
      first_name: json['first_name'],
      second_name: json['second_name'] ?? "", // Use default value if null
      surname: json['surname'],
      second_surname: json['second_surname'] ?? "", // Use default value if null
      email: json['email'],
      phone_number: json['phone_number'],
      age: json['age'],
      budget: json['budget'],
    );
  }
}
