import 'comment.dart';

class FakePostData
{
  String userImageUrl;
  String userName;
  String postImage;
  String postCaption;
  int commentsNumber;
  List<Comment>? comments;

  FakePostData({
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.postCaption,
    required this.commentsNumber,
    this.comments,
});
}

