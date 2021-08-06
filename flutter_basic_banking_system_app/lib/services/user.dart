class User {
  final String name;
  final double amount;
  final String email;

  User({required this.name, required this.amount, required this.email});

  User.fromMap(Map<String, dynamic> res)
      : name = res["name"],
        amount = res["amount"],
        email = res["email"];

  Map<String, Object?> toMap() {
    return {'name': name, 'amount': amount, 'email': email};
  }
}
