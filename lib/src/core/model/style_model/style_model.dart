import 'package:imagecreator_mac/src/utils/api_constants.dart';

class StyleModel {
  final String name;
  final String image;
  final Generator style;
  final bool disable;
  StyleModel(
      {required this.name,
      required this.image,
      required this.style,
      this.disable = false});
}
