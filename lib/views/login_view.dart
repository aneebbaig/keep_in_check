import 'package:flutter/material.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
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
              'Hello',
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
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
