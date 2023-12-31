import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/services/field_validations.dart';
import 'package:keep_in_check/viewmodel/auth_viewmodel.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/app_elevated_button.dart';
import 'package:keep_in_check/widgets/screen_padding.dart';
import 'package:provider/provider.dart';

import '../widgets/app_text_form_field.dart';

class LoginView extends StatelessWidget {
  static const route = 'loginViewRoute';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewmodel = context.watch<AuthViewModel>();

    return SafeArea(
      child: Scaffold(
        body: ScreenPadding(
          topPadding: 22,
          child: SingleChildScrollView(
            child: Form(
              key: authViewmodel.emailFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const AddHeight(0.03),
                  AppTextFormField(
                    controller: authViewmodel.email,
                    hintText: 'Enter your email',
                    label: 'Email',
                    validator: FieldValidations.emailValidator,
                    keyboardInputType: TextInputType.emailAddress,
                  ),
                  const AddHeight(0.04),
                  AppTextFormField(
                    controller: authViewmodel.password,
                    hintText: 'Enter you password',
                    keyboardInputType: TextInputType.visiblePassword,
                    obscureText: authViewmodel.obscurePass,
                    label: 'Password',
                    validator: FieldValidations.passwordValidator,
                    suffix: GestureDetector(
                      onTap: () {
                        authViewmodel.togglePass();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        child: Icon(authViewmodel.obscurePass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  if (authViewmodel.isRegister) ...[
                    const AddHeight(0.02),
                    AppTextFormField(
                      controller: authViewmodel.confirmPassword,
                      hintText: '********',
                      keyboardInputType: TextInputType.visiblePassword,
                      obscureText: authViewmodel.obscurePass,
                      label: 'Confirm Password',
                      validator: (text) =>
                          FieldValidations.confirmPasswordValidator(
                              text, authViewmodel.password.text),
                      suffix: IconButton(
                        icon: Icon(authViewmodel.obscurePass
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          authViewmodel.togglePass();
                        },
                      ),
                    ),
                  ],
                  const AddHeight(0.08),
                  authViewmodel.isLoading
                      ? const AppCircularProgressIndicator()
                      : Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              AppElevatedButton(
                                buttonText: authViewmodel.isRegister
                                    ? 'Register'
                                    : 'Log In',
                                onPressed: () {
                                  if (authViewmodel.emailFormKey.currentState!
                                      .validate()) {
                                    authViewmodel.isRegister
                                        ? authViewmodel
                                            .createUserUsingEmailAndPassword(
                                                context)
                                        : authViewmodel
                                            .signInUsingEmailAndPassword(
                                                context);
                                  }
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  authViewmodel.toggleRegister();
                                },
                                child: Text(
                                  authViewmodel.isRegister
                                      ? 'Already have an account? Login'
                                      : 'Create an account? Register',
                                ),
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.kPrimaryRedColor,
      ),
    );
  }
}
