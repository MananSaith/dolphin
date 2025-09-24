// lib/core/utils/validators.dart
class Validators {
  static String? email(String? value) {
    if (value == null || !value.contains('@')) return 'Invalid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) return 'Password too short';
    return null;
  }
}
