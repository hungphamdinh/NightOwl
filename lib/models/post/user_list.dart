import 'package:boilerplate/models/post/user.dart';
import 'package:flutter/material.dart';

class UserList {
  final List<User>? users;

  UserList({
    this.users,
  });

  factory UserList.fromJson(List<dynamic> json) {
    List<User> users = <User>[];
    users = json.map((post) => User.fromMap(post)).toList();

    return UserList(
      users: users,
    );
  }
}
