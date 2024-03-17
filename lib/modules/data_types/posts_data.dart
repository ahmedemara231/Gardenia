import 'comment.dart';

class PostData
{
  String userImageUrl;
  String userName;
  String postImage;
  String postCaption;
  int commentsNumber;
  List<Comment>? comments;

  PostData({
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.postCaption,
    required this.commentsNumber,
    this.comments,
});
}