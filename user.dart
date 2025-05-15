class UserModel {
  String email;
  String password;
  String currency;
  bool darkModeEnabled;
  bool biometricEnabled;

  UserModel({
    required this.email,
    required this.password,
    required this.currency,
    this.darkModeEnabled = false,
    this.biometricEnabled = false,
  });
}
