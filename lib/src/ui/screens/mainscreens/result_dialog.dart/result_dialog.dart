import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/navigation/navigation.dart';
import '../../../../core/service/api_service.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';

class ResultDialog extends StatelessWidget {
  final String url;
  final Uint8List? image;
  const ResultDialog({super.key, required this.url, this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.dialogColor,
      insetPadding: EdgeInsets.symmetric(
          horizontal: context.width * 0.2, vertical: context.height * 0.1),
      child: Container(
        color: AppColors.dialogColor,
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.02, vertical: context.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    ApiService.saveImage(context, url: url, image: image);
                  },
                  icon: SvgPicture.string(
                    AppAssets.downloadLogo,
                    width: 25,
                    height: 25,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      NavigationService.goBack();
                    },
                    icon: SvgPicture.string(
                      AppAssets.cancel,
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    )),
              ],
            ),
            IconButton(
                onPressed: () async {
                  final newimage =
                      await ApiService.shareImage(url: url, image: image);
                  if (image != null) {
                    Share.shareXFiles([XFile(newimage!.path)]);
                  }
                },
                icon: SvgPicture.string(
                  AppAssets.share,
                  width: 25,
                  height: 25,
                )),
            Expanded(
              child: Center(
                child: image == null
                    ? Image.network(
                        url,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.memory(
                        image!,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
