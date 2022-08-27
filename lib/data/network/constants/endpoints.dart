import 'package:boilerplate/data/network/apis/configsAPI/configsAPI.dart';

class Endpoints {
  static String baseUrl = ConfigsAPI.baseUrl(false);
  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;
  // booking endpoints
  static String getUsers = baseUrl + 'users';
  static String getTasks = baseUrl + 'tasks';
}
