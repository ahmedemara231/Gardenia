class ApiConstants
{
  // base url
  static const String baseUrl = 'https://ce34-45-246-233-71.ngrok-free.app/api/v1/';

  // Auth
  static const String login = 'login';
  static const String signUp = 'register';
  static const String forgotPassword = 'password/forget_password';
  static const String sendCode = 'password/otp_password';
  static const String resetPassword = 'password/reset_password';
  static const String refreshToken = 'refresh';
  static const String logout = 'logout';

  // posts
  static const String getPosts = 'get_posts';
  static const String createPost = 'create_post';
  static const String updatePost = 'posts';
  static const String deletePost = 'delete_post';

  // comments
  static const String getComments = 'posts/comments';
  static const String createComment = 'posts/create_comments';
  static const String deleteComment = 'comments';

  // categories
  static const String allCategories = 'AllCategories';
}