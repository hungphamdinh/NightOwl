import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/post/user.dart';
import 'package:boilerplate/models/post/user_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<UserList?> emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UserList?> fetchPostsFuture =
      ObservableFuture<UserList?>(emptyPostResponse);

  @observable
  UserList? userList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getUsers() async {
    final future = _repository.getUsers();
    fetchPostsFuture = ObservableFuture(future);

    future.then((postList) {
      this.userList = postList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future login(User data) async {
    final future = _repository.login(data);

    future.then((res) {
      return res;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
