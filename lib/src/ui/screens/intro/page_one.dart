import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/core/navigation/navigation.dart';
import 'package:imagecreator_mac/src/ui/compnents/gradient_button.dart';
import 'package:imagecreator_mac/src/ui/compnents/gradient_text.dart';
import 'package:imagecreator_mac/src/ui/compnents/svg_provider.dart';
import 'package:imagecreator_mac/src/ui/screens/intro/page_two.dart';
import 'package:imagecreator_mac/src/utils/app_assets.dart';
import 'package:imagecreator_mac/src/utils/app_colors.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../../../main.dart';
import '../../../utils/app_constants.dart';

class PageOneScreen extends StatefulWidget {
  const PageOneScreen({super.key});

  @override
  State<PageOneScreen> createState() => _PageOneScreenState();
}

class _PageOneScreenState extends State<PageOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        padding: EdgeInsets.only(left: context.width * 0.05),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                SvgImage(AppAssets.firstBackground, source: SvgSource.string),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GradientText(
                    "Welcome",
                    gradient: AppColors.gradientText,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    "AI Image Generator & BG Remover",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      height: 49 / 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  const Text(
                    "The world’s Biggest advanced AI Image Generator and Background Remover.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 29 / 20,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  GradientButton(
                      onTap: () {
                        NavigationService.navigateToScreen(const PageTwo());
                        storageService.set(AppConstants.introDone, "done");
                      },
                      text: "Get Started")
                ],
              ),
            ),
            Expanded(
                child: Image.asset(
              AppAssets.firPageSideImages,
              fit: BoxFit.cover,
            ))
          ],
        ),
      ),
    );
  }
}
