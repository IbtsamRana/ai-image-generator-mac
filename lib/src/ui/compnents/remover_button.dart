import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:imagecreator_mac/src/utils/app_assets.dart';
import 'package:imagecreator_mac/src/utils/app_colors.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

class RemoverButton extends StatelessWidget {
  final String image;
  final String text;
  final void Function() onTap;
  final bool disable;
  const RemoverButton(
      {super.key,
      required this.image,
      required this.text,
      this.disable = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: context.width * 0.07,
            height: context.height * 0.13,
            padding: EdgeInsets.only(
                top: context.height * 0.02, bottom: context.height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  const GradientBoxBorder(gradient: AppColors.gradientButton),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  image,
                  width: context.width * 0.03,
                  height: context.height * 0.045,
                ),
                Text(
                  text,
                  style:
                      const TextStyle(color: AppColors.darkPink, fontSize: 16),
                )
              ],
            ),
          ),
        ),
        if (disable)
          Positioned(
            right: context.width * 0.005,
            top: context.height * 0.01,
            child: SvgPicture.string(
              AppAssets.crown,
              height: context.height * 0.02,
            ),
          )
      ],
    );
  }
}
