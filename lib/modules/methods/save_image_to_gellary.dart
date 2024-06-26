import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../model/remote/api_service/service/constants.dart';

Future<void> saveImage(String imageUrl)async
{
  var response = await Dio().get(
      '${ApiConstants.baseUrlForImages}$imageUrl',
      options: Options(responseType: ResponseType.bytes)
  );

  await ImageGallerySaver.saveImage(
    Uint8List.fromList(response.data),
    quality: 60,
    name: "hello",
  );
}
