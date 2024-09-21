import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/register_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/common/view/dta_text_field.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/features/auth/provider/auth_providers.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/extensions.dart';

class SignUpDialog extends ConsumerStatefulWidget {
  const SignUpDialog({super.key});

  @override
  ConsumerState<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends ConsumerState<SignUpDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  Gender gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(authenticationProvider);

    return AlertDialog(
      backgroundColor: appColors.accent,
      title: Text(
        'Sign Up',
        style: TextStyle(
          color: appColors.surface,
          fontSize: 40,
          fontFamily: Constants.fontDMSerifDisplay,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DTATextField(
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
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: Gender.values.map((g) {
                    return ZoomTapDetector(
                      onTap: () => setState(() => gender = g),
                      child: AnimatedContainer(
                        duration: Durations.short4,
                        decoration: BoxDecoration(
                          color: gender == g
                              ? appColors.primaryLight
                              : appColors.secondaryDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            g.name.capitalizeFirst,
                            style: context.bodyMedium?.copyWith(
                              color: gender == g
                                  ? appColors.secondaryDark
                                  : appColors.primaryLight,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              DTATextField(
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
              DTATextField(
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
                        r'special character (@$!%*?&).';
                  }
                  return null;
                },
              ),
              DTATextField(
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
              if (registerState.hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    registerState.error?.toString() ??
                        'Unexpected error occurred! Please try again later.',
                    style: context.labelSmall?.copyWith(
                      color: appColors.primaryMedium,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              else
                const SizedBox(height: 24),
              DTAButton.filled(
                enabled: !registerState.isLoading,
                text: 'Submit',
                backgroundColor: appColors.primaryDark,
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await ref
                        .read(authenticationProvider.notifier)
                        .registerUser(
                          RegisterRequest(
                            firstName: nameController.text.trim(),
                            email: emailController.text.trim(),
                            gender: gender,
                            password: passwordController.text.trim(),
                          ),
                        );

                    final registerState = ref.read(authenticationProvider);
                    if (!registerState.hasError) {
                      context
                        ..pop<void>()
                        ..showSnackbar(
                          '✅ Registration successful! Please log in to '
                          'continue.',
                        );
                    }
                  }
                },
              ),
            ],
          ),
        ),
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
