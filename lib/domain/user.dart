class User {
  final int id;
  final String name;
  final String typeUser;
  final String email;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.typeUser,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'typeUser': typeUser,
      'email': email,
      'address': address,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      typeUser: json["typeUser"],
      name: json["name"], 
      email: json["email"], 
      address: json["address"],
    );
  }
}