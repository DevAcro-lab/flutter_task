import 'package:flutter/material.dart';
import 'package:flutter_task/configures/app_spaces.dart';
import 'package:flutter_task/utils/assets.dart';
import 'package:flutter_task/utils/customs/custom_loader.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppSpaces.largeSpace(context),
            const Image(
              image: AssetImage(AppAssets.logo),
            ),
            customLoader(),
            //
          ],
        ),
      ),
    );
  }
}
