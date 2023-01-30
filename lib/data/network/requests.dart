class LoginRequest {
  String email;
  String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

class RegisterRequest {
  final String userName;
  final String countryCode;
  final String phone;
  final String email;
  final String password;
  final String profilePicture;

  RegisterRequest({
    required this.userName,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
