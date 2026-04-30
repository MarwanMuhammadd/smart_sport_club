class AuthRegisterParams {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? nationalId;
  String? password;
  bool? isAdmin;

  AuthRegisterParams({
    this.password,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.nationalId,
    this.isAdmin = false,
  });
  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "nationalId": nationalId,
      "isAdmin": isAdmin ?? false,
    };
  }
}
