import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/post/user_list.dart';

import '../../../../models/post/user.dart';

class UserAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UserAPI(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<UserList> getUsers() async {
    try {
      final res = await _dioClient.get(Endpoints.getUsers);
      return UserList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<dynamic> login(User body) async {
    try {
      final res = await _dioClient.post(Endpoints.login, data: body);
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
