import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagecreator_mac/main.dart';
import 'package:imagecreator_mac/src/core/model/tool_model/tool_model.dart';
import 'package:imagecreator_mac/src/ui/compnents/side_selection_button.dart';
import 'package:imagecreator_mac/src/ui/compnents/svg_provider.dart';
import 'package:imagecreator_mac/src/ui/screens/mainscreens/background_remover/background_remover.dart';
import 'package:imagecreator_mac/src/ui/screens/mainscreens/image_generator/image_generator.dart';
import 'package:imagecreator_mac/src/ui/screens/mainscreens/premium_screen.dart/premium_screen.dart';
import 'package:imagecreator_mac/src/utils/app_assets.dart';
import 'package:imagecreator_mac/src/utils/app_colors.dart';
import 'package:imagecreator_mac/src/utils/app_constants.dart';
import 'package:imagecreator_mac/src/utils/app_icons.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  ToolName selected = ToolName.imageGenrator;
  ToolName hovered = ToolName.none;
  int index = 0;
  final List<Widget> widgets = [
    const ImageGenerator(),
    const BackgroundRemover(),
    const PremiumScreen()
  ];
  @override
  void initState() {
    Future.delayed(Durations.extralong4, () {
      if (!user.value.isPremium) {
        selection(
          ToolName.premiumScreen,
        );
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ToolModel> toolsList = [
      ToolModel(
          image: AppIcons.aiImageGenerator,
          name: "AI Image Generator",
          toolName: ToolName.imageGenrator),
      ToolModel(
          image: AppIcons.backgroundRemover,
          name: "Background Remover",
          toolName: ToolName.backgroundRemover,
          addDottedLine: true),
      if (!user.value.isPremium)
        ToolModel(
            image: AppIcons.restorePurchase,
            name: "Restore Purchase",
            toolName: ToolName.restorPurchase),
      ToolModel(
          image: AppIcons.rateUs, name: "Rate us", toolName: ToolName.rateUs),
      ToolModel(
          image: AppIcons.shareUs,
          name: "Share us",
          toolName: ToolName.shareUs,
          addDottedLine: true),
      ToolModel(
          image: AppIcons.feedback,
          name: "Feedback",
          toolName: ToolName.feedback),
      ToolModel(
          image: AppIcons.privacy,
          name: "Privacy Policy",
          toolName: ToolName.privacyPolicy),
      ToolModel(
        image: AppIcons.termsOfuse,
        name: "Terms of use",
        toolName: ToolName.termsOfUse,
      )
    ];
    return Scaffold(
      body: Container(
          width: context.width,
          height: context.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: SvgImage(AppAssets.radialGradient,
                      source: SvgSource.string))),
          child: Row(
            children: [
              Container(
                width: 300,
                padding: const EdgeInsets.only(right: 15),
                decoration: const BoxDecoration(color: AppColors.sideBarColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final data in toolsList)
                      Padding(
                        padding: EdgeInsets.only(top: context.height * 0.02),
                        child: SideSelectionButton(
                            image: data.image,
                            addLine: data.addDottedLine,
                            name: data.name,
                            tool: data.toolName,
                            selected: selected == data.toolName,
                            onTap: () {
                              selection(data.toolName);
                            },
                            onHover: (val) {
                              setState(() {
                                hovered = val;
                              });
                            },
                            ishovered: hovered == data.toolName),
                      ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          width: 250,
                          height: 130,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          margin: EdgeInsets.only(
                              left: 15,
                              right: 10,
                              bottom: context.height * 0.05),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: AppColors.selectioncolors,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(13.97)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 60),
                                child: Text(
                                  "Speed up your work 15X Faster and take the designs to the next level",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selection(ToolName.premiumScreen);
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 220,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white)),
                                  child: const Center(
                                    child: Text(
                                      'Upgrade To Premium',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Transform.translate(
                            offset: const Offset(20, -40),
                            child: Image.asset(
                              AppAssets.premumAsset,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(child: widgets[index])
            ],
          )),
    );
  }

  void selection(
    ToolName name,
  ) {
    switch (name) {
      case ToolName.imageGenrator:
        setState(() {
          selected = name;
          index = 0;
        });
        break;
      case ToolName.backgroundRemover:
        setState(() {
          selected = name;
          index = 1;
        });
        break;
      case ToolName.premiumScreen:
        setState(() {
          selected = name;
          index = 2;
        });
        break;
      case ToolName.feedback:
        launchUrl(Uri.parse(
          'mailto:Arslanahmed.112200i@gmail.com',
        ));
        break;
      case ToolName.restorPurchase:
        subscriptionsController.restoreSubscription();
        break;
      case ToolName.privacyPolicy:
        launchUrl(
            Uri.parse(
                'https://appcodersios.blogspot.com/2024/02/App-Coders-Privacy-Policy.html'),
            mode: LaunchMode.externalApplication);
        break;
      case ToolName.termsOfUse:
        launchUrl(
            Uri.parse(
                'https://appcodersios.blogspot.com/2024/02/App-Coders-Terms-Of-Use.html'),
            mode: LaunchMode.externalApplication);
        break;
      case ToolName.shareUs:
        Share.share('''🌟 Hey Friend! 🌟

Just found the coolest app to jazz up your pics! 📸 It's the AI Image Generator – turns your photos into jaw-dropping art in seconds! 🎨✨

Check it out! ${Platform.isMacOS ? "https://apps.apple.com/us/app/ai-image-creator/id6477715324" : "https://apps.apple.com/us/app/ai-art-generator-bg-remover/id6477200348"} ''');
        break;
      case ToolName.rateUs:
        launchUrl(Uri.parse(
            "https://apps.apple.com/us/app/ai-photo-generator-remove-bg/id6477715324"));

      default:
    }
  }
}
