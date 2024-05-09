import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_images.dart';

import 'package:keep_in_check/services/field_validations.dart';
import 'package:keep_in_check/modules/core/viewmodel/auth_viewmodel.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_elevated_button.dart';
import 'package:keep_in_check/widgets/screen_padding.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom/custom_text_form_field.dart';
import '../../../../widgets/custom/custom_circular_progress_indicator.dart';

class LoginView extends StatelessWidget {
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
                  CustomTextFormField(
                    controller: authViewmodel.email,
                    hintText: 'Enter your email',
                    label: 'Email',
                    validator: AppValidators.emailValidator,
                    keyboardInputType: TextInputType.emailAddress,
                  ),
                  const AddHeight(0.02),
                  CustomTextFormField(
                    controller: authViewmodel.password,
                    hintText: 'Enter you password',
                    keyboardInputType: TextInputType.visiblePassword,
                    obscureText: authViewmodel.obscurePass,
                    label: 'Password',
                    validator: AppValidators.passwordValidator,
                    suffix: GestureDetector(
                      onTap: () {
                        authViewmodel.togglePass();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        child: Image.asset(
                          !authViewmodel.obscurePass
                              ? AppIcons.hidePasswordIcon
                              : AppIcons.showPasswordIcon,
                          scale: 25,
                        ),
                      ),
                    ),
                  ),
                  if (authViewmodel.isRegister) ...[
                    const AddHeight(0.02),
                    // CustomTextFormField(
                    //   controller: authViewmodel.confirmPassword,
                    //   hintText: '********',
                    //   keyboardInputType: TextInputType.visiblePassword,
                    //   obscureText: authViewmodel.obscurePass,
                    //   label: 'Confirm Password',
                    //   validator: (text) =>
                    //       AppValidators.confirmPasswordValidator(
                    //           text, authViewmodel.password.text),
                    //   suffix: IconButton(
                    //     icon: Icon(authViewmodel.obscurePass
                    //         ? Icons.visibility
                    //         : Icons.visibility_off),
                    //     onPressed: () {
                    //       authViewmodel.togglePass();
                    //     },
                    //   ),
                    // ),
                    CustomTextFormField(
                      controller: authViewmodel.confirmPassword,
                      hintText: 'Re-enter you password',
                      keyboardInputType: TextInputType.visiblePassword,
                      obscureText: authViewmodel.obscurePass,
                      label: 'Confirm Password',
                      validator: (text) =>
                          AppValidators.confirmPasswordValidator(
                              text, authViewmodel.password.text),
                      suffix: GestureDetector(
                        onTap: () {
                          authViewmodel.togglePass();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          child: Image.asset(
                            !authViewmodel.obscurePass
                                ? AppIcons.hidePasswordIcon
                                : AppIcons.showPasswordIcon,
                            scale: 25,
                          ),
                        ),
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
                              CustomElevatedButton(
                                buttonText: authViewmodel.isRegister
                                    ? 'Register'
                                    : 'Log In',
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
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
