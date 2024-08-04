import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/ui/screens/intro/page_one.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../../../main.dart';
import '../../../core/navigation/navigation.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_constants.dart';
import '../../compnents/svg_provider.dart';
import '../mainscreens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      NavigationService.replaceScreen(
          storageService.get(AppConstants.introDone) == null
              ? const PageOneScreen()
              : MainScreen(
                  key: appstateKey,
                ));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: SvgImage(AppAssets.firstBackground,
                    source: SvgSource.string),
                fit: BoxFit.cover)),
        child: Center(
          child: Image.asset(
            AppAssets.logo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
