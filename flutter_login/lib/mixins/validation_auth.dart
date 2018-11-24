class ValidationMixins {
  String validateEmail(text) {
    if (!text.contains("@")) {
      return "Invalid email";
    }
    return null;
  }

  String validatePassword(password) {
    if (!password.contains("@")) {
      return "Invalid password";
    }
    return null;
  }
}
