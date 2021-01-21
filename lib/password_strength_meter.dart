import 'package:flutter/material.dart';
import 'helpers/password_validator.dart';
import 'widgets/strength_meter.dart';

class PasswordStrengthMeter extends FormField<String> {
  final TextEditingController controller;
  final bool showPasswordStrengthMeter;
  final PasswordValidator validationAlgorithm;

  @override
  _PasswordStrengthMeterState createState() => _PasswordStrengthMeterState();

  PasswordStrengthMeter({
    double strengthMeterWidth,
    double strengthMeterHeigth,
    BoxDecoration strengthMeterDecoration,
    Key key,
    this.controller,
    this.showPasswordStrengthMeter = true,
    String initialValue,
    FocusNode focusNode,
    InputDecoration decoration,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    VoidCallback onEditingComplete,
    TextStyle style,
    FormFieldSetter<String> onSaved,
    this.validationAlgorithm,
    ValueChanged<String> onFieldSubmitted,
    ValueChanged<String> onChanged,
    bool enabled,
    bool autofocus = false,
    bool obscureText = false,
    bool showCursor,
    bool enableSuggestions = false,
    int maxLines = 1,
    int minLines,
    int maxLength,
    AutovalidateMode autovalidateMode,
  })  : assert(initialValue == null || controller == null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength > 0),
        assert(autovalidateMode != null),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validationAlgorithm.validator,
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> field) {
            final _PasswordStrengthMeterState state =
                field as _PasswordStrengthMeterState;
            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      suffixIcon: GestureDetector(
                        key: Key('Obscure text button'),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: !obscureText
                              ? Theme.of(field.context).accentColor
                              : Colors.grey,
                        ),
                        onTap: () {
                          field.setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            return Column(
              children: [
                TextField(
                  controller: state._effectiveController,
                  focusNode: focusNode,
                  decoration:
                      effectiveDecoration.copyWith(errorText: field.errorText),
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  style: style,
                  autofocus: autofocus,
                  showCursor: showCursor,
                  obscureText: obscureText,
                  maxLines: maxLines,
                  minLines: minLines,
                  maxLength: maxLength,
                  onChanged: onChangedHandler,
                  onEditingComplete: onEditingComplete,
                  onSubmitted: onFieldSubmitted,
                  enabled: enabled ?? decoration?.enabled ?? true,
                ),
                const SizedBox(
                  height: 10,
                ),
                showPasswordStrengthMeter
                    ? LayoutBuilder(
                        builder: (context, constraints) => StrengthMeter(
                          key: Key('Strength Meter'),
                              level: validationAlgorithm.passwordLevel,
                          width: strengthMeterWidth == null
                              ? constraints.maxWidth
                              : strengthMeterWidth,
                            height: strengthMeterHeigth == null ? 15: strengthMeterHeigth,
                          decoration: strengthMeterDecoration,
                            ),)
                    : Container(),
              ],
            );
          },
        );
}

class _PasswordStrengthMeterState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  PasswordStrengthMeter get widget => super.widget as PasswordStrengthMeter;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value;
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}
