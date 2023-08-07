class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:4000";

  // static const String baseUrl = "http://192.168.101.6:4000";
  // static const String baseUrl = "http://172.26.0.95:4000";

  //===================User Routes =====================================
  static const String signIn = "/users/signIn";
  static const String signUp = "/users/signUp";

  //=======================Posts Routes ================================
  static const String getAllPosts = '/posts/getAllPosts';
  static const String addPosts = '/posts/addPosts';
  static const String uploadImage = "/posts/uploadImage/";
  static const String getMyPosts = "/posts/getMyPosts";
  static String getPostById(String postId) => "/posts/$postId";
  static String updatePost(String postId) => "/posts/getMyPosts/$postId";
  static String deletePost(String postId) => "/posts/getMyPosts/$postId";
 
}
