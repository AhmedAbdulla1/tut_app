class LoginRequest {
  String email;
  String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

class RegisterRequest {
  String email;
  String password;
  String userName;
  String phone;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.userName,
    required this.phone,
  });
}
