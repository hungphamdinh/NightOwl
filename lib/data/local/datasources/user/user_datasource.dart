import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/models/post/user.dart';
import 'package:boilerplate/models/post/user_list.dart';
import 'package:sembast/sembast.dart';

class UserDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _usersStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  UserDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(User post) async {
    return await _usersStore.add(_db, post.toMap());
  }

  Future<int> count() async {
    return await _usersStore.count(_db);
  }

  Future<List<User>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _usersStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final users = User.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      users.id = snapshot.key;
      return users;
    }).toList();
  }

  Future<UserList> getPostsFromDb() async {

    print('Loading from database');

    // post list
    var usersList;

    // fetching data
    final recordSnapshots = await _usersStore.find(
      _db,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if(recordSnapshots.length > 0) {
      usersList = UserList(
          users: recordSnapshots.map((snapshot) {
            final post = User.fromMap(snapshot.value);
            // An ID is a key of a record from the database.
            post.id = snapshot.key;
            return post;
          }).toList());
    }

    return usersList;
  }

  Future<int> update(User user) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(user.id));
    return await _usersStore.update(
      _db,
      user.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(User user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    return await _usersStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _usersStore.drop(
      _db,
    );
  }

}
