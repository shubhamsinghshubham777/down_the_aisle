import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:core/models/auth/login_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/common/view/dta_text_field.dart';
import 'package:frontend/features/auth/provider/auth_providers.dart';
import 'package:frontend/features/main/view/main_screen.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/utils.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(authenticationProvider);

    ref.listen(authenticationProvider, (oldState, newState) {
      if (oldState is AsyncLoading &&
          newState is AsyncData &&
          newState.valueOrNull != null) {
        context
          ..pop<void>()
          ..pushReplacement(const MainScreen());
      }

      if (newState is AsyncError) {
        debugLog(newState.error, stackTrace: newState.stackTrace, tag: _tag);
      }
    });

    return AlertDialog(
      backgroundColor: appColors.primaryLight,
      title: const Text(
        'Login',
        style: TextStyle(
          fontSize: 40,
          fontFamily: Constants.fontDMSerifDisplay,
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DTATextField(
              useLightTheme: true,
              labelText: 'E-mail',
              controller: emailController,
              validator: (email) => email?.isEmail ?? false
                  ? null
                  : 'Please enter a valid e-mail',
              keyboardType: TextInputType.emailAddress,
            ),
            DTATextField(
              useLightTheme: true,
              labelText: 'Password',
              isSecure: true,
              isLastField: true,
              controller: passwordController,
              validator: (password) => password?.isNotEmpty ?? false
                  ? null
                  : 'Please enter a password',
              keyboardType: TextInputType.emailAddress,
            ),
            if (loginState.hasError)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  loginState.error is DioException
                      ? (loginState.error as DioException?)
                              ?.response
                              ?.data
                              .toString() ??
                          'Unexpected error occurred! Please try again later.'
                      : loginState.error.toString(),
                  style: context.bodyMedium?.copyWith(color: appColors.accent),
                ),
              )
            else
              const SizedBox(height: 24),
            DTAButton.filled(
              enabled: !loginState.isLoading,
              text: 'Submit',
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  final request = LoginRequest(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );

                  await ref
                      .read(authenticationProvider.notifier)
                      .loginUser(request);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

const _tag = 'login_dialog';
