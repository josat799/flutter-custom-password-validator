import 'package:flutter/material.dart';
import '../helpers/password_level.dart';

class StrengthMeter extends StatelessWidget {
  final PasswordLevel level;
  final double height;
  final double width;
  final BoxDecoration decoration;
  Key key;

  StrengthMeter({this.level, this.width, this.height, this.decoration, this.key});

  Container passwordStrengthMeterItem(Color color, double width) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(top: 10),
      decoration: decoration == null ? BoxDecoration(
        border: Border.all(color: Colors.black),
      ) : decoration,
      child: level == PasswordLevel.Very_Good
          ? passwordStrengthMeterItem(Colors.green, width)
          : level == PasswordLevel.Very_Bad
              ? passwordStrengthMeterItem(Colors.red, width)
              : Stack(
                  children: [
                    passwordStrengthMeterItem(Colors.red, width),
                    level == PasswordLevel.Bad
                        ? passwordStrengthMeterItem(Colors.orange, width / 2)
                        : level == PasswordLevel.Okay
                            ? passwordStrengthMeterItem(Colors.orange, width)
                            : Stack(
                                children: [
                                  passwordStrengthMeterItem(
                                      Colors.green, width),
                                  passwordStrengthMeterItem(
                                      Colors.orange, width / 2)
                                ],
                              ),
                  ],
                ),
    );
  }
}
