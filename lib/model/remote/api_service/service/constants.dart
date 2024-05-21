class ApiConstants
{
  static const String baseUrlForImages = 'https://c271-45-244-45-80.ngrok-free.app';
  static const String baseUrl = '$baseUrlForImages/api/v1/';

  // timeout durations
  static Duration timeoutDuration = const Duration(seconds: 15);

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
  static const String updatePost = 'update_post';
  static const String deletePost = 'delete_post';

  // comments
  static const String getComments = 'posts/comments';
  static const String createComment = 'posts/create_comments';
  static const String deleteComment = 'comments';

  // plants
  static const String allCategories = 'AllCategories';
  static const String popularPlants = 'plants/popular';
  static const String plantsByCategory = 'plants';

  // profile
  static const String getProfileData = 'profile';
  static const String updateProfile = 'update_profile';
}