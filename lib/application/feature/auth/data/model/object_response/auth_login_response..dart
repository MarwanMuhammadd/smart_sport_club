class AuthLoginResponse {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  int? expiresIn;
  String? refreshToken;
  DateTime? refreshTokenExpiration;
  dynamic membershipId;
  dynamic digitalAccessKey;

  AuthLoginResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.expiresIn,
    this.refreshToken,
    this.refreshTokenExpiration,
    this.membershipId,
    this.digitalAccessKey,
  });

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponse(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      expiresIn: json['expiresIn'] as int?,
      refreshToken: json['refreshToken'] as String?,
      refreshTokenExpiration: json['refreshTokenExpiration'] == null
          ? null
          : DateTime.parse(json['refreshTokenExpiration'] as String),
      membershipId: json['membershipId'] as dynamic,
      digitalAccessKey: json['digitalAccessKey'] as dynamic,
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
    'digitalAccessKey': digitalAccessKey,
  };
}
