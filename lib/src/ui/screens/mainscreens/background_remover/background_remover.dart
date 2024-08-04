import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagecreator_mac/src/ui/compnents/remover_button.dart';
import 'package:imagecreator_mac/src/utils/app_assets.dart';
import 'package:imagecreator_mac/src/utils/app_colors.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../../../../main.dart';
import '../../../../core/model/purchase_model/purchase_model.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/service/api_service.dart';
import '../../../../utils/api_constants.dart';
import '../../../../utils/app_constants.dart';
import '../cameraview/camera_view.dart';
import '../result_dialog.dart/result_dialog.dart';

class BackgroundRemover extends StatefulWidget {
  const BackgroundRemover({super.key});

  @override
  State<BackgroundRemover> createState() => _BackgroundRemoverState();
}

class _BackgroundRemoverState extends State<BackgroundRemover> {
  late num chances;

  @override
  void initState() {
    chances = storageService.get(AppConstants.backgroundremover) ?? 1;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PurchaseModel>(
        valueListenable: user,
        builder: (context, model, child) {
          return Container(
              padding: EdgeInsets.only(
                left: context.width * 0.05,
                right: context.width * 0.05,
                top: context.height * 0.02,
                bottom: context.height * 0.02,
              ),
              color: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                    width: context.width,
                    height: context.height,
                  ),
                  Positioned(
                    left: context.width * 0.03,
                    top: context.height * 0.08,
                    child: SvgPicture.string(
                      AppAssets.circle,
                      height: context.height * 0.35,
                    ),
                  ),
                  Positioned(
                    right: context.width * 0.03,
                    top: context.height * 0.17,
                    child: SvgPicture.string(
                      AppAssets.doubleCircle,
                      height: context.height * 0.2,
                    ),
                  ),
                  Positioned(
                    right: context.width * 0.14,
                    top: context.height * 0.12,
                    child: SvgPicture.string(
                      AppAssets.rainBowLines,
                      height: context.height * 0.05,
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Background Remover",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.width * 0.16,
                              right: context.width * 0.16,
                              top: context.height * 0.03),
                          child: const Text(
                            "Fast, easy background remover for everyone",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 28),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.02,
                        ),
                        const Center(
                          child: Text(
                            "Erase image background free and replace it with different backgrounds of your choice.",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppAssets.mainBanner,
                              width: context.width * 0.2,
                              height: context.height * 0.2,
                            ),
                            SvgPicture.string(
                              AppAssets.rowLine,
                              width: context.width * 0.1,
                            ),
                            Container(
                              width: context.width * 0.35,
                              height: context.height * 0.3,
                              padding: EdgeInsets.only(
                                  top: context.height * 0.03,
                                  bottom: context.height * 0.06),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: "Upload Your Image",
                                        style: TextStyle(
                                            color: AppColors.darkPink,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                    if (!model.isPremium)
                                      TextSpan(
                                          text: "  ($chances Credits Left)",
                                          style: const TextStyle(
                                              color: AppColors.lightPink,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400))
                                  ])),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Stack(
                                        children: [
                                          RemoverButton(
                                              image: AppAssets.camera,
                                              text: "Camera",
                                              onTap: () async {
                                                if (user.premium) {
                                                  final file = await showDialog<
                                                          File?>(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          const MainContainerWidget());
                                                  if (file != null) {
                                                    checkCondition(file,
                                                        premium:
                                                            model.isPremium);
                                                  }
                                                } else {
                                                  appstateKey.currentState
                                                      ?.selection(ToolName
                                                          .premiumScreen);
                                                }
                                              }),
                                          if (!model.isPremium)
                                            Positioned(
                                              right: 0,
                                              child: Transform.translate(
                                                offset: Offset(
                                                    context.width * 0.003,
                                                    -context.height * 0.008),
                                                child: SvgPicture.string(
                                                  AppAssets.locked,
                                                  width: 18,
                                                  height: 18,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      RemoverButton(
                                          image: AppAssets.gallery,
                                          text: "Photo",
                                          onTap: () async {
                                            final images =
                                                await ApiService.picImage(
                                                    ImageSource.gallery);
                                            if (images != null) {
                                              checkCondition(images,
                                                  premium: model.isPremium);
                                            }
                                          })
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ]),
                ],
              ));
        });
  }

  void checkCondition(File file, {required bool premium}) {
    if (premium) {
      _removeBackground(file, premium: premium);
    } else if (chances > 0) {
      _removeBackground(file, premium: premium);
    } else {
      appstateKey.currentState?.selection(ToolName.premiumScreen);
    }
  }

  void _removeBackground(File image, {required bool premium}) async {
    try {
      onLoading();
      if (chances > 0) {
        final data = await ApiService.removeBackground(image);
        storageService.set(AppConstants.backgroundremover, chances - 1);
        setState(() {
          chances = chances - 1;
        });

        NavigationService.goBack();
        if (mounted) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) =>
                  ResultDialog(
                    image: data,
                    url: "",
                  ));
        }
      }
      // await NavigationService.navigateToScreen(ViewImageUi(
      //   url: "",
      //   image: data,
      // ));
    } catch (e) {
      NavigationService.goBack();
    }
  }
}
