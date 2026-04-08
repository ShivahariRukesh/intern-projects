class AuthFieldValidator {
  static String? validateUsername(String? value) {
    if (value == null ||
        value.isEmpty ||
        RegExp(r'^[a-zA-Z0-9_]{3,16}$').hasMatch(value)) {
      return null;
    } else {
      return "Enter a valid username";
    }
  }

  static String? validatePassword(String? value) {
    if (value == null ||
        value.isEmpty ||
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value)) {
      return null;
    } else {
      return "Enter a valid password";
    }
  }
}
