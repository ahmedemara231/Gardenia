class Comment
{
  String? userImageUrl;
  String userName;
  String comment;
  String time;
  int userId;
  int id;

  Comment({
    required this.userImageUrl,
    required this.userName,
    required this.comment,
    required this.time,
    required this.userId,
    required this.id,
});

  factory Comment.fromJson(Map<String,dynamic> commentJsonData)
  {
    return Comment(
      userImageUrl: commentJsonData['user']['image'],
      userName: commentJsonData['user']['username'],
      comment: commentJsonData['content'],
      time: commentJsonData['created_at'],
      userId: commentJsonData['user_id'],
      id: commentJsonData['id'],
    );
  }
}