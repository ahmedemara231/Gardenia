import 'package:flutter/cupertino.dart';

abstract class HandleUpdatePost
{
  Future<void> handleEditProcess(
      BuildContext context,{
        required int index,
        required String newCaption
      });

  Future<void> handleDeleteProcess(
      BuildContext context,{
        required int postId,
      });

  Future<void> handleSaveImageToGallery(BuildContext context, String imageUrl);
}