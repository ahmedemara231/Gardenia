class PostData2
{
  int? postId;
  int? userId;
  String? caption;
  String? image;
  String creationTime;
  int? commentsCount;
  String? userName;
  String? userImage;

  PostData2({
    required this.postId,
    required this.caption,
    required this.image,
    required this.commentsCount,
    required this.creationTime,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  factory PostData2.fromJson(Map<String,dynamic> postJsonData)
  {
    return PostData2(
        postId: postJsonData['id'],
        caption: postJsonData['caption'],
        image: postJsonData['image'],
        creationTime: postJsonData['created_at'],
        commentsCount: postJsonData['comments_count'],
        userId: postJsonData['user_id']??'',
        userName: postJsonData['user']['username'],
        userImage: postJsonData['user']['image']
    );
  }
}