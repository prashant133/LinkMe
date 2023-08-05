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

  //=======================Rooms Routes ================================
  static const String getAllRooms = '/rooms/getAllRooms';
  static const String addRooms = '/rooms/addRooms';
  static const String uploadImage = "/rooms/uploadImage/";
  static const String getMyRooms = "/rooms/getMyRooms";
  static String getRoomById(String roomId) => "/rooms/$roomId";
  static String updateRoom(String roomId) => "/rooms/getMyRooms/$roomId";
  static String deleteRoom(String roomId) => "/rooms/getMyRooms/$roomId";
  // static const String imageUrl = "http://10.0.2.2:4000/uploads/";
  // static const String imageUrl = "http://192.168.101.11:4000/uploads/";
}
