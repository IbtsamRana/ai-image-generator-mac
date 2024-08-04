import 'dart:io';

import 'package:camera_macos/camera_macos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';
import 'package:path/path.dart' as pathJoiner;
import 'package:path_provider/path_provider.dart';

import '../../../../utils/app_colors.dart';

class MainContainerWidget extends StatefulWidget {
  const MainContainerWidget({super.key});

  @override
  MainContainerWidgetState createState() => MainContainerWidgetState();
}

class MainContainerWidgetState extends State<MainContainerWidget> {
  CameraMacOSController? macOSController;

  String? selectedVideoDevice;
  GlobalKey cameraKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    macOSController?.destroy();
    super.dispose();
  }

  Future<String> get imageFilePath async => pathJoiner.join(
      (await getApplicationDocumentsDirectory()).path,
      "P_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}.png");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
        backgroundColor: AppColors.dialogColor,
        insetPadding: EdgeInsets.symmetric(
            horizontal: context.width * 0.2, vertical: context.height * 0.1),
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                  width: size.width,
                  height: size.height * 0.7,
                  child: CameraMacOSView(
                    key: cameraKey,
                    fit: BoxFit.fitWidth,
                    cameraMode: CameraMacOSMode.photo,
                    pictureFormat: PictureFormat.png,
                    onCameraInizialized: (CameraMacOSController controller) {
                      setState(() {
                        macOSController = controller;
                      });
                    },
                    onCameraDestroyed: () {
                      return const Text("destroyed");
                    },
                    enableAudio: false,
                  )),
              IconButton(
                  onPressed: onCameraButtonTap,
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ))
            ],
          ),
          Positioned(
            right: 20,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
          )
        ]));
  }

  Future<void> listVideoDevices() async {
    try {
      List<CameraMacOSDevice> videoDevices =
          await CameraMacOS.instance.listDevices(
        deviceType: CameraMacOSDeviceType.video,
      );
      setState(() {
        if (videoDevices.isNotEmpty) {
          selectedVideoDevice = videoDevices.first.deviceId;
        }
      });
    } catch (e) {}
  }

  Future<void> onCameraButtonTap() async {
    try {
      CameraMacOSFile? imageData = await macOSController!.takePicture();
      if (imageData != null) {
        savePicture(imageData.bytes!);
      }
    } catch (e) {}
  }

  Future<void> savePicture(Uint8List photoBytes) async {
    try {
      String filename = await imageFilePath;
      File f = File(filename);
      if (f.existsSync()) {
        f.deleteSync(recursive: true);
      }
      f.createSync(recursive: true);
      f.writeAsBytesSync(photoBytes);
      Navigator.pop(context, f);
    } catch (e) {}
  }
}

CameraImageData argb2bitmap(CameraImageData content) {
  final Uint8List updated = Uint8List(content.bytes.length);
  for (int i = 0; i < updated.length; i += 4) {
    updated[i] = content.bytes[i + 1];
    updated[i + 1] = content.bytes[i + 2];
    updated[i + 2] = content.bytes[i + 3];
    updated[i + 3] = content.bytes[i];
  }

  const int headerSize = 122;
  final int contentSize = content.bytes.length;
  final int fileLength = contentSize + headerSize;

  final Uint8List headerIntList = Uint8List(fileLength);

  final ByteData bd = headerIntList.buffer.asByteData();
  bd.setUint8(0x0, 0x42);
  bd.setUint8(0x1, 0x4d);
  bd.setInt32(0x2, fileLength, Endian.little);
  bd.setInt32(0xa, headerSize, Endian.little);
  bd.setUint32(0xe, 108, Endian.little);
  bd.setUint32(0x12, content.width, Endian.little);
  bd.setUint32(0x16, -content.height, Endian.little); //-height
  bd.setUint16(0x1a, 1, Endian.little);
  bd.setUint32(0x1c, 32, Endian.little); // pixel size
  bd.setUint32(0x1e, 3, Endian.little); //BI_BITFIELDS
  bd.setUint32(0x22, contentSize, Endian.little);
  bd.setUint32(0x36, 0x000000ff, Endian.little);
  bd.setUint32(0x3a, 0x0000ff00, Endian.little);
  bd.setUint32(0x3e, 0x00ff0000, Endian.little);
  bd.setUint32(0x42, 0xff000000, Endian.little);

  headerIntList.setRange(
    headerSize,
    fileLength,
    updated,
  );

  return CameraImageData(
      bytes: headerIntList,
      width: content.width,
      height: content.height,
      bytesPerRow: content.bytesPerRow);
}

CameraImageData rgba2bitmap(CameraImageData content) {
  print(content.bytes.sublist(0, 4));
  const int headerSize = 122;
  final int contentSize = content.bytes.length;
  final int fileLength = contentSize + headerSize;

  final Uint8List headerIntList = Uint8List(fileLength);

  final ByteData bd = headerIntList.buffer.asByteData();
  bd.setUint8(0x0, 0x42);
  bd.setUint8(0x1, 0x4d);
  bd.setInt32(0x2, fileLength, Endian.little);
  bd.setInt32(0xa, headerSize, Endian.little);
  bd.setUint32(0xe, 108, Endian.little);
  bd.setUint32(0x12, content.width, Endian.little);
  bd.setUint32(0x16, -content.height, Endian.little); //-height
  bd.setUint16(0x1a, 1, Endian.little);
  bd.setUint32(0x1c, 32, Endian.little); // pixel size
  bd.setUint32(0x1e, 3, Endian.little); //BI_BITFIELDS
  bd.setUint32(0x22, contentSize, Endian.little);
  bd.setUint32(0x36, 0x000000ff, Endian.little);
  bd.setUint32(0x3a, 0x0000ff00, Endian.little);
  bd.setUint32(0x3e, 0x00ff0000, Endian.little);
  bd.setUint32(0x42, 0xff000000, Endian.little);

  headerIntList.setRange(
    headerSize,
    fileLength,
    content.bytes,
  );

  return CameraImageData(
      bytes: headerIntList,
      width: content.width,
      height: content.height,
      bytesPerRow: content.bytesPerRow);
}
