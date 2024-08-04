import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/utils/api_constants.dart';

extension AppContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
}

extension StringManipulator on String {
  String get urlName {
    return split('/').last;
  }
}

extension GeneratorNames on Generator {
  String get getLink {
    return linksMap[this]!;
  }

  String get getLinkName {
    return linksMap[this]!.urlName;
  }

  String get generatorName {
    return generatorMap[this]!;
  }
}
