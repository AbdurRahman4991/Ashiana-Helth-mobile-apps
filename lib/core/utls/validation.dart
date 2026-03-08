class Validators {

  static String? phone(String? value) {

    if (value == null || value.isEmpty) {
      return "Phone number required";
    }

    if (value.length != 11) {
      return "Phone must be 11 digits";
    }

    return null;
  }

  static String? password(String? value) {

    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
}