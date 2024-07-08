import 'package:hive/hive.dart';

@HiveType(typeId: 0,adapterName: 'PostData')
class PostData2 extends HiveObject
{
  @HiveField(0)
  int? postId;

  @HiveField(1)
  int? userId;

  @HiveField(2)
  String? caption;

  @HiveField(3)
  String? image;

  @HiveField(4)
  String creationTime;

  @HiveField(5)
  int? commentsCount;

  @HiveField(6)
  String? userName;

  @HiveField(7)
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