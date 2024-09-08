import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/utils/constants.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({super.key});

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appColors.accent,
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: appColors.surface,
                fontSize: 40,
                fontFamily: Constants.fontDMSerifDisplay,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage:
                    imageBytes != null ? MemoryImage(imageBytes!) : null,
                backgroundColor: appColors.surface,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.accent.withOpacity(0.35),
                ),
                child: IconButton(
                  onPressed: selectImage,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.photo,
                      size: 32,
                      color: appColors.surface,
                    ),
                  ),
                  tooltip: 'Select profile image',
                ),
              ),
            ],
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AuthTextField(
                labelText: 'First Name',
                controller: nameController,
                keyboardType: TextInputType.name,
                maxLength: 10,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              _AuthTextField(
                labelText: 'E-mail',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'E-mail cannot be empty';
                  }
                  if (!(value?.isEmail ?? false)) {
                    return 'Please enter a valid e-mail';
                  }
                  return null;
                },
              ),
              _AuthTextField(
                labelText: 'Password',
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                isSecure: true,
                maxLength: 16,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Password cannot be empty';
                  }
                  if (value?.isNotSecurePassword ?? false) {
                    return 'Password must be at least 8 characters long '
                        'and include uppercase, lowercase, number, and '
                        'special character (@\$!%*?&).';
                  }
                  return null;
                },
              ),
              _AuthTextField(
                labelText: 'Repeat Password',
                controller: repeatPasswordController,
                keyboardType: TextInputType.visiblePassword,
                isLastField: true,
                isSecure: true,
                maxLength: 16,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DTAButton.filled(
                text: 'Submit',
                backgroundColor: appColors.primaryDark,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.pop();
                  } else {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
      withData: true,
    );
    if (result != null) {
      setState(() => imageBytes = result.files.first.bytes);
    }
  }
}

class _AuthTextField extends StatefulWidget {
  const _AuthTextField({
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    this.isSecure = false,
    this.maxLength,
    this.isLastField = false,
  });

  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool isSecure;
  final int? maxLength;
  final bool isLastField;
  final TextInputType keyboardType;

  @override
  State<_AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<_AuthTextField> {
  late bool localIsSecure = widget.isSecure;
  final borderWithSurfaceColor = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: appColors.surface),
  );
  final borderWithPrimaryColor = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: appColors.primaryMedium),
  );
  final secondaryTextStyle = TextStyle(
    color: appColors.surface,
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
        cursorColor: appColors.surface,
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
                      color: appColors.surface,
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
          color: appColors.surface,
          fontFamily: !localIsSecure ? Constants.fontKrylon : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}

extension _PasswordValidator on String {
  bool get isNotSecurePassword {
    // Regex pattern for password validation
    return !RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(this);
  }
}
