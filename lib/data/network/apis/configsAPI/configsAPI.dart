class ConfigsAPI {
  ConfigsAPI._();
  static const String url = "https://taskmanage998.herokuapp.com/api/";
  static const String localhost = "http://localhost:8080/api/";
  static String baseUrl(bool isRemote) {
    return isRemote == true ? url : localhost;
  }

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;
}
