class AuthRegisterResponse {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  int? expiresIn;
  String? refreshToken;
  DateTime? refreshTokenExpiration;
  String? membershipId;
  String? message;

  AuthRegisterResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.expiresIn,
    this.refreshToken,
    this.refreshTokenExpiration,
    this.membershipId,
    this.message,
  });

  factory AuthRegisterResponse.fromJson(Map<String, dynamic> json) {
    final fallbackName = (json['fullName'] ?? json['name'])?.toString().trim();
    final nameParts = fallbackName?.split(RegExp(r'\s+')) ?? const <String>[];

    return AuthRegisterResponse(
      id: json['id']?.toString(),
      firstName:
          json['firstName']?.toString() ??
          (nameParts.isNotEmpty ? nameParts.first : null),
      lastName:
          json['lastName']?.toString() ??
          (nameParts.length > 1 ? nameParts.skip(1).join(' ') : null),
      email: json['email']?.toString(),
      token: json['token']?.toString(),
      expiresIn: int.tryParse(json['expiresIn']?.toString() ?? ''),
      refreshToken: json['refreshToken']?.toString(),
      refreshTokenExpiration: json['refreshTokenExpiration'] == null
          ? null
          : DateTime.tryParse(json['refreshTokenExpiration'].toString()),
      membershipId: json['membershipId']?.toString(),
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'token': token,
    'expiresIn': expiresIn,
    'refreshToken': refreshToken,
    'refreshTokenExpiration': refreshTokenExpiration?.toIso8601String(),
    'membershipId': membershipId,
    'message': message,
  };
}
