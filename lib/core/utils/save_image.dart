import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SaveImage {
  Future<File> getImage({required String url}) async {
    /// Get Image from server
    final Response res = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    /// Get App local storage
    final Directory appDir = await getApplicationDocumentsDirectory();

    /// Generate Image Name
    final String imageName = url.split('/').last;

    /// Create Empty File in app dir & fill with new image
    final File file = File(join(appDir.path, imageName));

    file.writeAsBytesSync(res.data as List<int>);
    dev.log('PATH FOR SHARE : ${file.path.toString()}');
    return file;
  }

  Future<File> getImageForShare(String url) async {
    final response = await http.get(Uri.parse(url));

    final documentDirectory = await getExternalStorageDirectory();

    final file = File(join(documentDirectory!.path, 'image.png'));

    file.writeAsBytesSync(response.bodyBytes);
    dev.log('PATH FOR WA : ${file.path.toString()}');
    return file;
  }

  Future<File> convertMultiImg(Uint8List img) async {
    final documentDirectory = await getExternalStorageDirectory();

    /// Generate Image Name
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    final file = File("${join(documentDirectory!.path, getRandomString(10))}.jpeg");

    file.writeAsBytesSync(img);

    return file;
  }
}
