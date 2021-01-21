

import 'password_validator.dart';

class EasyPasswordValidator extends PasswordValidator {
  @override
  setValidator() {
    return (password) {
      passwordMetric = 10;
      if (password.isEmpty) {
        return "Must be at least 8 characters long!";
      }
      String hint = "";

      if (password.length < 8) {
        hint += "* Must be at least 8 characters long! \n";
      } else
        passwordMetric -= (password.length / 2).round();

      if (!password.contains(RegExp(r'\d')))
        hint += "* Must contain at least one digit! \n";
      else
        passwordMetric -= 2;

      if (!password.contains(RegExp(r'[A-Z]')))
        hint += "* Must contain at least one capital letter! \n";
      else
        passwordMetric -= 2;

      if (!password.contains(RegExp(r'[a-z]')))
        hint += "* Must contain at least one smaller letter! \n";
      else
        passwordMetric -= 2;

      if (passwordMetric > 0) return hint;
      return null;
    };
  }
}
