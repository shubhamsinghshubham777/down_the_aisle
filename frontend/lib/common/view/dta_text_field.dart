import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/utils/constants.dart';

class DTATextField extends StatefulWidget {
  const DTATextField({
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    super.key,
    this.isSecure = false,
    this.maxLength,
    this.isLastField = false,
    this.useLightTheme = false,
  });

  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool isSecure;
  final int? maxLength;
  final bool isLastField;
  final TextInputType keyboardType;
  final bool useLightTheme;

  @override
  State<DTATextField> createState() => _DTATextFieldState();
}

class _DTATextFieldState extends State<DTATextField> {
  late bool localIsSecure = widget.isSecure;
  late final borderWithSurfaceColor = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.useLightTheme ? appColors.secondaryDark : appColors.surface,
    ),
  );
  late final borderWithPrimaryColor = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.useLightTheme
          ? appColors.secondaryMedium
          : appColors.primaryMedium,
    ),
  );
  late final secondaryTextStyle = TextStyle(
    color: widget.useLightTheme ? appColors.secondaryDark : appColors.surface,
    fontFamily: Constants.fontKrylon,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: widget.controller,
        cursorWidth: 1,
        cursorHeight: 16,
        cursorOpacityAnimates: true,
        cursorRadius: const Radius.circular(24),
        cursorColor:
            widget.useLightTheme ? appColors.secondaryDark : appColors.surface,
        decoration: InputDecoration(
          enabledBorder: borderWithSurfaceColor,
          focusedBorder: borderWithPrimaryColor,
          errorBorder: borderWithPrimaryColor,
          focusedErrorBorder: borderWithSurfaceColor,
          labelText: widget.labelText,
          labelStyle: secondaryTextStyle,
          helperStyle: secondaryTextStyle,
          errorStyle: TextStyle(color: appColors.primaryMedium),
          suffixIcon: !widget.isSecure
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () => setState(
                      () => localIsSecure = !localIsSecure,
                    ),
                    icon: Icon(
                      localIsSecure ? Icons.visibility : Icons.visibility_off,
                      color: widget.useLightTheme
                          ? appColors.secondaryDark
                          : appColors.surface,
                    ),
                  ),
                ),
          errorMaxLines: 5,
        ),
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        obscureText: localIsSecure,
        style: TextStyle(
          color: widget.useLightTheme
              ? appColors.secondaryDark
              : appColors.surface,
          fontFamily: !localIsSecure ? Constants.fontKrylon : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
