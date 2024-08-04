import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:imagecreator_mac/src/core/model/convas_model/convas_model.dart';
import 'package:imagecreator_mac/src/core/model/style_model/style_model.dart';
import 'package:imagecreator_mac/src/ui/compnents/gradient_button.dart';
import 'package:imagecreator_mac/src/ui/screens/mainscreens/result_dialog.dart/result_dialog.dart';
import 'package:imagecreator_mac/src/utils/app_assets.dart';
import 'package:imagecreator_mac/src/utils/app_colors.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../../../../main.dart';
import '../../../../core/model/purchase_model/purchase_model.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/service/api_service.dart';
import '../../../../utils/api_constants.dart';
import '../../../../utils/app_constants.dart';

class ImageGenerator extends StatefulWidget {
  const ImageGenerator({super.key});

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  Generator selection = Generator.fantasyWorld;
  PictureSizes sizes = PictureSizes.onebyone;
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<int> freeIndexes = [
    0,
    1,
    4,
    5,
    8,
    9,
    12,
    13,
    16,
    17,
    20,
    21,
    24,
    25,
    28,
    29,
    32,
    33,
    36,
    37,
    40,
    41,
    44,
    45,
    48,
    49,
    52,
    53,
    56,
    57,
    60,
    61,
    64,
    65,
    68,
    69,
    72,
    73,
    76,
    77,
    80,
    81,
    84,
    85,
    88,
    89,
    92,
    93,
    96,
    97,
    100,
    101,
    104,
    105,
    108,
    109,
    112,
    113,
    116,
    117
  ];
  late num chances;
  List<String> textList = [
    "acoustic-guitar-and-electric-guitar-connecte",
    "a-guy-coding-on-his-laptop-and-a-grocery-in-the-backg",
    "a-guy-trapped-in-the-virtual-network",
    "animal-with-four-legs-short-orange-nose-green-elephan",
    "a-tall-girl-with-medium-length-light-pink-with-a-pink",
    "beer-belly-chad-in-lederhosen",
    "create-a-proper-englishman-with-a-frog-head-holding-a",
    "cyborg-johann-wolfgang-goethe-thumb",
    "dark-shades-dark-rider-cold-runic-symbols-mysticism-a",
    "draw-a-full-body-picture-of-frankenstien-green-body-b",
    "draw-me-an-animated-island-with-a-rat",
    "erzahler-portrait-der-eine-geschichte-erzahlt-etwas-g",
    "full-body-character-on-genshin-impact-s-style-with-el",
    "full-body-shot-of-a-well-lit-blue-beret-clear-skin-sh",
    "generate-an-image-that-represents-fragmented-unison-o",
    "ghost-cybersecurity-anonymous-privacy-security",
    "girl-holding-a-stanley-tumbler",
    "girl-with-headphones-and-long-hair",
    "gwendoline-christie",
    "hinata-shy-hiding-behind-tree",
    "hockey-player-on-ice",
    "hulk-fighting-spider-man-in-kurdistan-with-kurdish-fl",
    "human-traffickin",
    "indian-boy-with-braids",
    "in-the-middle-writes-evan-craft",
    "iron-man-crossed-with-darth-vader",
    "isabella-has-long-dark-hair-which-she-often-ties-into",
    "izuku-midoriya-muscular-",
    "judge-dredd-",
    "lava-monster-entering-the-city",
    "link-as-a-magic-the-gathering-card",
    "local-male-wearing-a-blue-t-shirt",
    "loop-computer-science-lime-6542da",
    "many-local-tourists-in-minapin-village-market-near-ra",
    "mercury-elemnt-villian-f10e18",
    "milky-way-crypto-staking",
    "musketeers-standing-guard-at-a-city-gate-",
    "nathan-wang",
    "only-toys-were-a-helicopter-and-a-drum",
    "pink-elephant-",
    "police-car-chasing-another-car-and-its-porshe",
    "pov-translucent-veined-membrane-labia-spread-open-lev",
    "purpled-haired-anime-boy-with-blue-eyes-wearing-a-pur",
    "romeo-from-the-shakespeare-play-as-a-influencer",
    "smilling-man-standing-on-the-left-side-hugs-a-huge-ba",
    "sonic-in-cat-form",
    "supervillain-brain-evil",
    "wings-demon-devil-grey-skin-horns-smile-fire-full-bod",
    "woman-with-a-knight-helmet-with-a-sword-with-a-white-",
    "women-dressed-in-white-wearing-a-knight-helmet",
  ];
  @override
  void initState() {
    chances = storageService.get(AppConstants.imageGenerator) ?? 1;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.circular(
          12,
        ));

    final List<StyleModel> styleList = Generator.values
        .map((e) => StyleModel(
            name: e.generatorName,
            image: "assets/styles/${e.getLinkName}.png",
            style: e))
        .toList();
    final List<ConvasModel> convasList = [
      ConvasModel(name: "1:1", pictureSizes: PictureSizes.onebyone),
      ConvasModel(name: "2:3", pictureSizes: PictureSizes.twobyThree),
      ConvasModel(name: "3:2", pictureSizes: PictureSizes.threebytwo),
      ConvasModel(name: "3:4", pictureSizes: PictureSizes.threebyfour),
      ConvasModel(name: "4:3", pictureSizes: PictureSizes.fourbyThree),
    ];

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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "AI Image Generator",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Write Prompt",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      if (!model.isPremium)
                        Text(
                          "$chances Credtis",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  SizedBox(
                    width: context.width,
                    height: context.height * 0.15,
                    child: TextFormField(
                      controller: controller,
                      textAlignVertical: TextAlignVertical.top,
                      textInputAction: TextInputAction.done,
                      expands: true,
                      maxLines: null,
                      maxLength: 250,
                      validator: (String? val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Please enter text";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: "Enter your text here",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          fillColor: Colors.transparent,
                          filled: true),
                    ),
                  ),
                  const Text(
                    "Choose Style",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: context.width,
                    height: 140,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: styleList.length,
                        itemBuilder: (context, index) {
                          final e = styleList[index];
                          return Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: context.width * 0.01),
                                child: InkWell(
                                  onTap: () {
                                    if (model.isPremium) {
                                      setState(() {
                                        selection = e.style;
                                      });
                                    } else {
                                      if (freeIndexes.contains(index)) {
                                        setState(() {
                                          selection = e.style;
                                        });
                                      } else {
                                        appstateKey.currentState
                                            ?.selection(ToolName.premiumScreen);
                                      }
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(9.76),
                                  child: Container(
                                    width: 110,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        color: selection == e.style
                                            ? null
                                            : AppColors.sideBarColor,
                                        gradient: selection == e.style
                                            ? AppColors.selectionGradient
                                            : null,
                                        borderRadius:
                                            BorderRadius.circular(9.76)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            e.image,
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Text(
                                          e.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (!model.isPremium &&
                                  !freeIndexes.contains(index))
                                Transform.translate(
                                  offset: const Offset(100, 0),
                                  child: SvgPicture.string(
                                    AppAssets.locked,
                                    width: 18,
                                    height: 18,
                                  ),
                                )
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  const Text(
                    "Choose Canvas",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: context.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: convasList
                          .map(
                            (e) => Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (model.isPremium) {
                                      setState(() {
                                        sizes = e.pictureSizes;
                                      });
                                    } else {
                                      if (convasList.first == e) {
                                        setState(() {
                                          sizes = e.pictureSizes;
                                        });
                                      } else {
                                        appstateKey.currentState
                                            ?.selection(ToolName.premiumScreen);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: sizes == e.pictureSizes
                                            ? Border.all(color: Colors.white)
                                            : const GradientBoxBorder(
                                                gradient: AppColors
                                                    .selectionGradient)),
                                    child: Center(
                                        child: Text(
                                      e.name,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                                  ),
                                ),
                                if (convasList.first != e && !model.isPremium)
                                  Transform.translate(
                                    offset: const Offset(100, -8),
                                    child: SvgPicture.string(
                                      AppAssets.locked,
                                      width: 18,
                                      height: 18,
                                    ),
                                  )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  const Text(
                    "Prompts",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        itemCount: textList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final data = textList[index];
                          return Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: context.width * 0.01),
                                child: InkWell(
                                  onTap: () {
                                    if (model.isPremium) {
                                      controller.text = data;
                                    } else {
                                      if (freeIndexes.contains(index)) {
                                        setState(() {
                                          controller.text = data;
                                        });
                                      } else {
                                        appstateKey.currentState
                                            ?.selection(ToolName.premiumScreen);
                                      }
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(9.76),
                                  child: Container(
                                    width: 80,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        color: AppColors.sideBarColor,
                                        borderRadius:
                                            BorderRadius.circular(9.76)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            "assets/images/$data.jpg",
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          data,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (!model.isPremium &&
                                  !freeIndexes.contains(index))
                                Transform.translate(
                                  offset: const Offset(70, 0),
                                  child: SvgPicture.string(
                                    AppAssets.premium,
                                    width: 16,
                                    height: 16,
                                  ),
                                )
                            ],
                          );
                        }),
                  ),
                  const Spacer(),
                  Center(
                    child: GradientButton(
                      text: "Generate",
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          if (user.premium) {
                            _generateImage(premium: model.isPremium);
                          } else if (chances > 0) {
                            _generateImage(premium: model.isPremium);
                          } else {
                            appstateKey.currentState
                                ?.selection(ToolName.premiumScreen);
                          }
                        }
                      },
                      height: context.height * 0.08,
                      width: context.width * 0.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _generateImage({required bool premium}) async {
    onLoading();

    try {
      if (chances > 0) {
        final data = await ApiService.generateImage(controller.text.trim(),
            size: sizes, styleSelection: selection);
        storageService.set(AppConstants.imageGenerator, chances - 1);
        setState(() {
          chances = chances - 1;
        });
        NavigationService.goBack();
        if (mounted) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) => ResultDialog(url: data));
        }
      }
      // NavigationService.navigateToScreen(ViewImageUi(url: data));
    } catch (error) {
      NavigationService.goBack();
    }
  }
}
