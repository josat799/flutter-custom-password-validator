import 'package:flutter/widgets.dart';
import 'password_level.dart';

abstract class PasswordValidator {
  PasswordLevel passwordLevel;
  FormFieldValidator<String> validator;
  int _passwordMetric;

  updatePasswordLevel() {
    if (_passwordMetric <= 1) this.passwordLevel = PasswordLevel.Very_Good;
    else if (_passwordMetric < 4) this.passwordLevel = PasswordLevel.Good;
    else if (_passwordMetric < 6) this.passwordLevel = PasswordLevel.Okay;
    else if (_passwordMetric < 8) this.passwordLevel = PasswordLevel.Bad;
    else if (_passwordMetric <= 10) this.passwordLevel = PasswordLevel.Very_Bad;
    else this.passwordLevel = PasswordLevel.Very_Bad;
  }

  FormFieldValidator<String> setValidator() {
  }

  int get passwordMetric => _passwordMetric;

  set passwordMetric(int value) {
    _passwordMetric = value;
    updatePasswordLevel();
  }

  PasswordValidator() {
    passwordMetric = 10;
    validator = setValidator();
    updatePasswordLevel();
  }
}

