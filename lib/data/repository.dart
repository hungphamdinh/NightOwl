import 'dart:async';

import 'package:boilerplate/data/local/datasources/user/user_datasource.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/post/user.dart';
import 'package:boilerplate/models/post/user_list.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import 'local/constants/db_constants.dart';
import 'network/apis/posts/user_api.dart';

class Repository {
  // data source object
  final UserDataSource _userDataSource;

  // api objects
  final UserAPI _userAPI;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._userAPI, this._sharedPrefsHelper, this._userDataSource);

  // Post: ---------------------------------------------------------------------
  Future<UserList> getUsers() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _userAPI.getUsers().then((usersList) {
      usersList.users?.forEach((post) {
        _userDataSource.insert(post);
      });

      return usersList;
    }).catchError((error) => throw error);
  }

  Future<List<User>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _userDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(User user) => _userDataSource
      .insert(user)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(User user) => _userDataSource
      .update(user)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(User user) => _userDataSource
      .update(user)
      .then((id) => id)
      .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future login(User data) async {
    // return await Future.delayed(Duration(seconds: 2), ()=> true);
    return await _userAPI.login(data).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
