class Validator {
  static String? validateRequired<T>(T? value, String fieldName) {
    if (value == null) {
      return "$fieldName required";
    }

    if (value is String && value.trim().isEmpty) {
      return "$fieldName required";
    }

    return null;
  }

  static String? validateFullName(String? value) {
    final requiredError = validateRequired(value, "Full name");
    if (requiredError != null) return requiredError;

    final normalized = value!.trim();
    if (normalized.length < 3) {
      return "Full name must be at least 3 characters";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email required";
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
      return "Invalid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password required";
    if (value.length < 6) return "Minimum 6 characters";
    if (!RegExp(r'[A-Z]').hasMatch(value)) return "Must contain uppercase";
    if (!RegExp(r'[!@#$%^&*]').hasMatch(value)) {
      return "Must contain special char";
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    final requiredError = validateRequired(value, "Confirm password");
    if (requiredError != null) return requiredError;
    if (value != originalPassword) return "Passwords do not match";
    return null;
  }
}
