import 'package:imagecreator_mac/src/utils/app_constants.dart';

class ConvasModel {
  final String name;

  final PictureSizes pictureSizes;
  final bool disable;
  ConvasModel(
      {required this.name, required this.pictureSizes, this.disable = false});
}
