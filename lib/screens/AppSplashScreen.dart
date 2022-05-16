import 'package:flutter/material.dart';
import 'package:sho_tam/screens/NewsScreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class AppSplashScreen extends StatelessWidget {
  static const routeName = '/app_splash_screen';

  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const NewsScreen(),
      duration: 2000,
      imageSize: 250,
      imageSrc: 'assets/images/app_icon.png',
      backgroundColor: Colors.white,
    );
  }
}