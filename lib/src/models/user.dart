class User {
  int? userId;
  String name;
  String currency;

  User({this.userId, required this.name,required this.currency});


  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'name': name,
      'currency': currency,
    };
  }

    factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      name: map['name'],
      currency: map['currency'],
    );
  }
}