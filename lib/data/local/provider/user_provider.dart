import 'package:boilerplate/models/post/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  void setUserInfo(User user) {
    this.user = user;
    debugPrint('setUser $user');
    notifyListeners();
  }

  User get userInfo => user;
}
