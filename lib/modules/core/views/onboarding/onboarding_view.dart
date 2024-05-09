import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/modules/core/viewmodel/onboarding_viewmodel.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom/custom_elevated_button.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Consumer<OnBoardingViewModel>(
              builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        provider.selectedScreen.image,
                        scale: 2,
                      ),
                      const AddHeight(0.05),
                      Text(
                        provider.selectedScreen.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const AddHeight(0.01),
                      Text(
                        provider.selectedScreen.subtitle,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: AppColors.kTextGreyColor,
                                ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.37,
                        color: provider.selectedScreen
                            .color, // You can change the color as per your requirement
                      ),
                    ),
                    Column(
                      children: [
                        const AddHeight(0.1),
                        CustomElevatedButton(
                          width: 0.8.sw,
                          onPressed: () {
                            provider.nextOnBoardingScreen();
                          },
                          buttonText: provider.selectedIndex == 2
                              ? "Login"
                              : 'Continue',
                          color: Colors.white,
                          textColor: AppColors.kTextGreyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // starting point
    path.lineTo(size.width, size.height); // bottom right
    path.lineTo(size.width, size.height * 0.15); // top right

    var firstEndpoint = Offset(size.width * 0.4, size.height * 0.2);
    var firstControlPoint = Offset(size.width * 0.7, 0);

    // Creating a wave effect
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndpoint.dx,
      firstEndpoint.dy,
    );

    var secondEndPoint = Offset(0, size.height * 0.23);
    var secondControlPoint = Offset(size.width * 0.18, size.height * 0.32);

    // Creating a wave effect
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
