class AppValidators {
  // Generic Required Field
  static String? requiredField(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return "${fieldName ?? 'Field'} is required";
    }
    return null;
  }

  // Email
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(pattern).hasMatch(value)) return "Enter a valid email";
    return null;
  }

  // Phone Number
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return "Phone is required";
    final pattern = r'^[0-9]{10,11}$';
    if (!RegExp(pattern).hasMatch(value)) return "Enter a valid phone number";
    return null;
  }

  // Password (strict requirements from backend)
  static String? password(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Password must be at least 8 characters";

    // Regex for: uppercase, lowercase, digit, special character
    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'[0-9]');
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!hasUppercase.hasMatch(value)) return "Must have one uppercase letter";
    if (!hasLowercase.hasMatch(value)) return "Must have one lowercase letter";
    if (!hasDigit.hasMatch(value)) return "Must have one digit";
    if (!hasSpecial.hasMatch(value)) return "Must have one special character";

    return null;
  }

  // Confirm Password
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) return "Confirm your password";
    if (value != password) return "Passwords do not match";
    return null;
  }

  // Name (letters only)
  static String? name(String? value) {
    if (value == null || value.isEmpty) return "Name is required";
    final pattern = r'^[a-zA-Z ]+$';
    if (!RegExp(pattern).hasMatch(value)) return "Letters only";
    return null;
  }

  // Membership / Sequence ID (numbers only)
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty)
      return "${fieldName ?? 'Field'} is required";
    final pattern = r'^[0-9]+$';
    if (!RegExp(pattern).hasMatch(value)) return "Enter numbers only";
    return null;
  }

  // Club Code (alphanumeric, format XXXX-XXXX-XXXX)
  static String? clubCode(String? value) {
    if (value == null || value.isEmpty) return "Club code is required";
    final pattern = r'^[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}$';
    if (!RegExp(pattern).hasMatch(value))
      return "Enter code like XXXX-XXXX-XXXX";
    return null;
  }

  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) return "Please enter OTP";
    if (value.length != length) return "OTP must be $length digits";
    if (!RegExp(r'^\d+$').hasMatch(value)) return "OTP must be numbers only";
    return null; // كله تمام
  }
}
