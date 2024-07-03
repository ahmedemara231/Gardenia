import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class PostData2 extends HiveObject
{
  @HiveField(0)

  @HiveField(1)
  int? postId;

  @HiveField(2)
  int? userId;

  @HiveField(3)
  String? caption;

  @HiveField(4)
  String? image;

  @HiveField(5)
  String creationTime;

  @HiveField(6)
  int? commentsCount;

  @HiveField(7)
  String? userName;

  @HiveField(8)
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