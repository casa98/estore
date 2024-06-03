class Validators {
  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required field';
    }
    return null;
  }

  static String? validateNumberWithPossibleDecimal(String? value) {
    if (validateEmpty(value) == null) {
      final numericRegExp = RegExp(r'^-?\d*\.?\d+$');
      if (!numericRegExp.hasMatch(value!)) {
        return 'Invalid number';
      }
      return null;
    }
    return 'Required field';
  }
}
