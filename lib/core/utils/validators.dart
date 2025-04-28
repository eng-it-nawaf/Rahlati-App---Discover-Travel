class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^.+@.+\..+$').hasMatch(value)) return 'Invalid email';
    return null;
  }
}