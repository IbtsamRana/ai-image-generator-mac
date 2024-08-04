import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/core/navigation/navigation.dart';
import 'package:imagecreator_mac/src/ui/screens/mainscreens/main_screen.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../../../main.dart';
import '../../../utils/app_assets.dart';
import '../../compnents/gradient_button.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        padding: EdgeInsets.only(
          left: context.width * 0.3,
          right: context.width * 0.3,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.pageTwoImages,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.3,
            ),
            const Text(
              "Create Your Photo to BG Remover",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  height: 54 / 40,
                  color: Colors.white),
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            GradientButton(
              onTap: () {
                NavigationService.replaceScreen(MainScreen(
                  key: appstateKey,
                ));
              },
              text: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
