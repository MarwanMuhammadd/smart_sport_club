// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthLoginParams {
  
  String? email;
  String? clubCode;
  String? password;
  bool? isAdmin;
  AuthLoginParams({
    this.email,
    this.clubCode,
    this.password,
    this.isAdmin = false,
  });
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "clubCode": clubCode,
      "password": password,
      "isAdmin": isAdmin,
    };
  }
}
