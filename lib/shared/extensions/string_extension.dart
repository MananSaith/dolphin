// lib/shared/extensions/string_extension.dart
extension StringExtensions on String {
  bool get isEmail => contains('@') && contains('.');
}
