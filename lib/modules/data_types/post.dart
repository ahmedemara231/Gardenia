class Post
{
  int postId;
  int userId;
  String? caption;
  String? image;
  String creationTime;
  int commentsCount;
  String userName;
  String? userImage;

  Post({
    required this.postId,
    required this.caption,
    required this.image,
    required this.commentsCount,
    required this.creationTime,
    required this.userId,
    required this.userName,
    required this.userImage,
});
}