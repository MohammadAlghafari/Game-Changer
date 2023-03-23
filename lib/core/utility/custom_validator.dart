
class CustomValidator {
  // check if is input empty or not
  static String? isRequired(String? inputValue) =>
      (inputValue == null || inputValue.isEmpty)
          ? "This Filed is Required"
          : null;
}
