import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:imagecreator_mac/src/utils/app_assets.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../main.dart';
import '../../../../core/model/tool_model/tool_model.dart';
import '../../../../core/service/subscription_service.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_icons.dart';
import '../../../compnents/gradient_button.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final _pageController = PageController(initialPage: 0);
  late Timer timer;
  final List<ToolModel> toolsList = [
    ToolModel(
        image: AppIcons.privacy,
        name: "Privacy Policy",
        toolName: ToolName.privacyPolicy),
    ToolModel(
        image: AppIcons.restorePurchase,
        name: "Restore Purchase",
        toolName: ToolName.restorPurchase),
    ToolModel(
        image: AppIcons.restorePurchase,
        name: "Free Plan",
        toolName: ToolName.imageGenrator),
    ToolModel(
      image: AppIcons.termsOfuse,
      name: "Terms of use",
      toolName: ToolName.termsOfUse,
    )
  ];

  final List<ToolModel> pager = [
    ToolModel(
        image: AppAssets.proImage,
        name: "Revolutionize art creation with our AI",
        toolName: ToolName.imageGenrator),
    ToolModel(
        image: AppAssets.removeImage,
        name: "Background Remover",
        toolName: ToolName.backgroundRemover),
  ];
  int pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _pageController.animateToPage(
        pageIndex == 0 ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<InAppModel>(
        valueListenable: subscriptionsController,
        builder: (context, controller, child) {
          return controller.productDetails.isEmpty
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Stack(children: [
                  Container(
                      width: context.width,
                      padding: EdgeInsets.only(
                        top: context.height * 0.02,
                      ),
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: context.height * 0.5,
                                  child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: pager.length,
                                      onPageChanged: (val) {
                                        setState(() {
                                          pageIndex = val;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              pager[index].image,
                                              width: context.width * 0.3,
                                            ),
                                            SizedBox(
                                              height: context.height * 0.02,
                                            ),
                                            SizedBox(
                                              width: context.width * 0.2,
                                              child: Text(
                                                pager[index].name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: context.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      2,
                                      (index) => AnimatedContainer(
                                            curve: Curves.linear,
                                            duration: Durations.medium2,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            width: pageIndex == index ? 20 : 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: pageIndex == index
                                                    ? AppColors.lightPink
                                                    : Colors.blueGrey),
                                          )),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: AppColors.sideBarColor,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    const Expanded(
                                      child: Text(
                                        "AI Photo Generator Remove BG",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: AppColors.selectioncolors,
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Pro",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ]),
                                  const Text(
                                    "Speed up your work 15X Faster and take the designs to the next level",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: controller.productDetails
                                          .map((e) => InkWell(
                                                onTap: () {
                                                  subscriptionsController
                                                      .setProduct(e);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      color: controller
                                                                      .selectProduct !=
                                                                  null &&
                                                              controller.selectProduct ==
                                                                  e
                                                          ? null
                                                          : AppColors
                                                              .sideBarColor,
                                                      gradient: controller
                                                                      .selectProduct !=
                                                                  null &&
                                                              controller.selectProduct ==
                                                                  e
                                                          ? AppColors
                                                              .selectionGradient
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: const GradientBoxBorder(
                                                          gradient: AppColors
                                                              .selectionGradient)),
                                                  width: 230,
                                                  height: 300,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 220,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors
                                                                    .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: controller.selectProduct !=
                                                                        null &&
                                                                    controller
                                                                            .selectProduct ==
                                                                        e
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .white)
                                                                : const GradientBoxBorder(
                                                                    gradient:
                                                                        AppColors
                                                                            .selectionGradient)),
                                                        child: Center(
                                                          child: Text(
                                                            duration(e.id),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        e.price,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      less(e.id, e.rawPrice,
                                                          e.currencySymbol),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        isTrial(e.id),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList()),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  if (controller.selectProduct == null)
                                    const Text(""),
                                  if (controller.selectProduct != null)
                                    isTrial2(controller.selectProduct!.id,
                                        controller.selectProduct!.price),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GradientButton(
                                    text: controller.selectProduct != null &&
                                            controller.selectProduct!.id ==
                                                yearly
                                        ? "Start For Free"
                                        : "Continue",
                                    onTap: () {
                                      if (controller.selectProduct == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Kindly select plan")));
                                        return;
                                      }
                                      if (controller.productDetails
                                          .where((p0) =>
                                              p0.id ==
                                              controller.selectProduct!.id)
                                          .where((element) =>
                                              element.rawPrice == 0)
                                          .isEmpty) {
                                        subscriptionsController.subscribe(
                                            product: controller.selectProduct!);
                                      } else {
                                        subscriptionsController.subscribe(
                                            product: controller.productDetails
                                                .where((p0) =>
                                                    p0.id ==
                                                    controller
                                                        .selectProduct!.id)
                                                .where((element) =>
                                                    element.rawPrice == 0)
                                                .first);
                                      }
                                    },
                                    height: context.height * 0.08,
                                    width: context.width * 0.3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                          bottom: 20,
                          left: context.width * 0.2,
                          right: context.width * 0.2),
                      width: context.width,
                      child: Table(
                        border: TableBorder.all(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        children: [
                          TableRow(
                              children: toolsList
                                  .map((val) => InkWell(
                                      onTap: () {
                                        selection(val.toolName);
                                      },
                                      child: SizedBox(
                                          height: 45.0,
                                          child: Center(
                                            child: Text(
                                              val.name,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))))
                                  .toList())
                        ],
                      )),
                ]);
        });
  }

  String duration(String productid) {
    if (productid == monthly) {
      return "Monthly";
    } else if (productid == yearly) {
      return "Yearly";
    } else {
      return "";
    }
  }

  String isTrial(String productid) {
    if (productid == monthly) {
      return "Basic";
    } else if (productid == yearly) {
      return "3 Days Free Trial";
    } else {
      return "";
    }
  }

  Widget isTrial2(String productid, String price) {
    if (productid == yearly) {
      return Text(
        "3 Days Free Trial, Then $price Yearly",
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    } else {
      return const Text("");
    }
  }

  Widget less(String productid, num price, String symbol) {
    if (productid == monthly) {
      return Text(
        "$symbol ${(price + (price * 0.145)).toStringAsFixed(2)} / Week",
        style: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.lineThrough,
            decorationColor: AppColors.lightPink),
      );
    } else if (productid == yearly) {
      return Text(
        "$symbol ${(price / 4).toStringAsFixed(2)} / Week",
        style: const TextStyle(
          color: Colors.white,
        ),
      );
    } else {
      return const Text("");
    }
  }

  void selection(
    ToolName name,
  ) {
    switch (name) {
      case ToolName.imageGenrator:
        appstateKey.currentState?.selection(ToolName.imageGenrator);
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

      default:
    }
  }
}
