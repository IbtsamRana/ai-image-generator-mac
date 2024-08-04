import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagecreator_mac/src/utils/extensions.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/api_constants.dart';
import '../../utils/app_constants.dart';

class ApiService {
  ApiService._();
  static final Dio _dio = Dio();
  static Future<String> generateImage(String text,
      {required PictureSizes size, required Generator styleSelection}) async {
    final String url = styleSelection.getLink;
    _dio.options.headers[ApiConstants.apiheader] = ApiConstants.apikey;

    final Map<String, dynamic> formData = {
      "text": text,
      "grid_size": "1",
      "width": "${_getSize(size).width.toInt()}",
      "height": "${_getSize(size).height.toInt()}",
      "image_generator_version": "standard"
    };
    try {
      final Response response = await _dio.post(url, data: formData);
      final Map<String, dynamic> jsondata = _decodeJson(response.data);
      return jsondata["output_url"];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Uint8List> removeBackground(
    File image,
  ) async {
    const String url = ApiConstants.removeBackground;

    var headers = {
      ApiConstants.backgroundapiheader: ApiConstants.backgroundApikey,
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('image_file', image.path));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      return await response.stream.toBytes();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Map<String, dynamic> _decodeJson(dynamic data) {
    if (data is String) {
      return jsonDecode(data);
    }
    return data;
  }

  static Size _getSize(PictureSizes sizes) {
    switch (sizes) {
      case PictureSizes.onebyone:
        return const Size(500, 500);
      case PictureSizes.threebyfour:
        return const Size(576, 480);
      case PictureSizes.twobyThree:
        return const Size(700, 500);
      case PictureSizes.threebytwo:
        return const Size(800, 400);
      case PictureSizes.fourbyThree:
        return const Size(1920, 1080);
      default:
        throw UnimplementedError();
    }
  }

  static Future<void> saveImage(BuildContext context,
      {required String url, Uint8List? image}) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    Uint8List? bytes = image;
    try {
      if (bytes == null) {
        final uri = Uri.parse(url);
        // Download image
        final http.Response response = await http.get(uri);
        bytes = response.bodyBytes;
      }
      if (Platform.isAndroid || Platform.isIOS) {
        await ImageGallerySaver.saveImage(bytes,
            name: "${DateTime.now().millisecondsSinceEpoch}");
      } else {
        final dir =
            await getPath("${DateTime.now().millisecondsSinceEpoch}.png");

        // Create an image name
        var filename = Platform.isAndroid || Platform.isIOS
            ? '$dir/${DateTime.now().millisecondsSinceEpoch}.png'
            : dir;

        // Save to filesystem
        final file = File(filename);
        await file.writeAsBytes(bytes);
      }

      // Get temporary directory

      message = 'Image saved to disk';
    } catch (e) {
      message = 'An error occurred while saving the image';
    }
    if (Platform.isMacOS) {
      return;
    }
    scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.only(
            left: context.width * 0.2, right: context.width * 0.2),
        content: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ))));
  }

  static Future<File?> shareImage(
      {required String url, Uint8List? image}) async {
    Uint8List? bytes = image;
    try {
      if (bytes == null) {
        final uri = Uri.parse(url);
        // Download image
        final http.Response response = await http.get(uri);
        bytes = response.bodyBytes;
      }

      final dir = await getApplicationDocumentsDirectory();

      // Create an image name
      var filename = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(bytes);
      return file;

      // Get temporary directory
    } catch (e) {
      return null;
    }
  }

  static Future<String> getPath(String desktoppath) async {
    if (Platform.isMacOS || Platform.isWindows) {
      final newpath = await getSaveLocation(suggestedName: desktoppath);
      return newpath!.path;
    }

    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    String path = directory!.path;
    String filepath = "";
    List<String> paths = path.split("/");

    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        filepath += "/$folder";
      } else {
        break;
      }
    }

    String name = Platform.isAndroid ? "/Download/AI Image Generator" : "";
    filepath = filepath + name;
    final savedDir = Directory(filepath);

    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return savedDir.path;
  }

  static Future<File?> picImage(ImageSource source) async {
    try {
      final newimage = await ImagePicker().pickImage(source: source);
      if (newimage != null) {
        return File(newimage.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
