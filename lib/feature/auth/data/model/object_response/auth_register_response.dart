class AuthRegisterResponse {
  String? message;

  AuthRegisterResponse({this.message});

  factory AuthRegisterResponse.fromJson(Map<String, dynamic> json) {
    return AuthRegisterResponse(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};
}
