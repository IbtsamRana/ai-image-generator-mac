import 'package:imagecreator_mac/src/utils/app_constants.dart';

class ToolModel {
  final String name;
  final String image;
  final ToolName toolName;
  final bool addDottedLine;
  ToolModel(
      {required this.name,
      required this.image,
      required this.toolName,
      this.addDottedLine = false});
}
