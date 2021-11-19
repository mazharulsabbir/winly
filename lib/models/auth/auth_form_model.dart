class AuthFormModel {
  AuthFormModel({
    this.name = "",
    this.username = "",
    this.email = "",
    this.phoneNumber = "",
    this.password = "",
    this.passwordConfirmation = "",
  });

  String? name;
  String? username;
  String? email;
  String? phoneNumber;

  String? password;
  String? passwordConfirmation;

  factory AuthFormModel.fromJson(Map<String, dynamic> json) => AuthFormModel(
        name: json['name'],
        username: json['username'],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "phone": phoneNumber,
        "password": password
      };
  @override
  String toString() {
    return 'User Form{name: $name, username: $username, email: $email, phoneNumber: $phoneNumber, password: $password, }';
  }
}
