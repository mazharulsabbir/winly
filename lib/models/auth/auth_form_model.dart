class AuthFormModel {
  AuthFormModel({
    this.name = "",
    this.username = "",
    this.email = "",
    this.phoneNumber = "",
    this.referralCode = "",
    this.password = "",
    this.passwordConfirmation = "",
  });

  String? name;
  String? username;
  String? email;
  String? phoneNumber;
  String? referralCode;
  String? password;
  String? passwordConfirmation;

  factory AuthFormModel.fromJson(Map<String, dynamic> json) => AuthFormModel(
        name: json['name'],
        username: json['username'],
        email: json["email"],
        phoneNumber: json["phone_number"],
        referralCode: json["referral_code"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "referral_code": referralCode,
        "password": password
      };
}
