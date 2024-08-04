import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../utils/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final double fontSize;
  const GradientButton(
      {super.key,
      required this.text,
      this.onTap,
      this.height,
      this.width,
      this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        width: width ?? context.width * 0.2,
        height: height ?? context.height * 0.06,
        decoration: BoxDecoration(
            gradient: AppColors.gradientButton, borderRadius: borderRadius),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
