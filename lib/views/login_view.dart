import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/app_elevated_button.dart';
import 'package:keep_in_check/widgets/screen_padding.dart';

class LoginView extends StatelessWidget {
  static const route = 'loginViewRoute';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ScreenPadding(
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
            const AddHeight(0.01),
            Text(
              'Please Enter you email',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const AddHeight(0.05),
            const AppTextFormField(),
            const AddHeight(0.05),
            Align(
              alignment: Alignment.center,
              child: AppElevatedButton(
                buttonText: 'Continue',
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Please enter your email',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintFadeDuration: Duration(
              milliseconds: 500,
            ),
          ),
        ),
      ],
    );
  }
}
