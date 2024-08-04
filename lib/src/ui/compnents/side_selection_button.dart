import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imagecreator_mac/src/utils/app_constants.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';

import '../../utils/app_colors.dart';

class SideSelectionButton extends StatelessWidget {
  final String image;
  final String name;
  final ToolName tool;
  final bool selected;
  final bool ishovered;
  final bool addLine;
  final void Function() onTap;
  final void Function(ToolName hover) onHover;
  const SideSelectionButton(
      {super.key,
      required this.image,
      required this.name,
      required this.tool,
      required this.selected,
      required this.onTap,
      required this.onHover,
      required this.addLine,
      required this.ishovered});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.29);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          onHover: (val) {
            if (val) {
              onHover(tool);
            } else {
              onHover(ToolName.none);
            }
          },
          child: Container(
            width: 250,
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                gradient:
                    selected || ishovered ? AppColors.selectionGradient : null,
                borderRadius: borderRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.string(
                  image,
                  width: 17,
                  height: 17,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
        if (addLine)
          Padding(
              padding: EdgeInsets.only(top: context.height * 0.02),
              child: const DottedLine(
                dashColor: Colors.white,
              ))
      ],
    );
  }
}
