class AppValidators {
  static String? requiredAmountField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value == "0") {
      return "Amount should be more than 0";
    }
    return null;
  }

  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}
