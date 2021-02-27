import 'package:path/path.dart';
// own import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_bloc/models/userModel.dart';

class UserDBProvider {
  // Create a singleton
  UserDBProvider();

  static final UserDBProvider db = UserDBProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await openDb();
    return _database;
  }

  Future openDb() async {
    // Get the location of our apps directory. This is where files for our app, and only our app, are stored.
    // Files in this directory are deleted when the app is deleted.
    return await openDatabase(join(await getDatabasesPath(), "my.db"), version: 1, onOpen: (db) async {
    }, onCreate: (Database db, int version) async {
      // Create the user table
      await db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY autoincrement,firstName TEXT,lastName TEXT,time Text)");
    });
  }

  Future insertUserData(UserModel model) async {
    final db = await database;
    return db.insert('user', model.toMap());
  }

  Future updateUser(UserModel model) async {
    final db = await database;
    return db.update('user', model.toMap(),
        where: "id = ?", whereArgs: [model.id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return db.delete('user', where: "id = ?", whereArgs: [id]);
  }
  Future<List<UserModel>> getUser() async {
    final db = await database;

    final List<Map<String, dynamic>> maps  = await db.query('user');
    List<UserModel> list = maps.isNotEmpty ? maps.map((note) => UserModel.fromMap(note)).toList() : [];

    return list;
  }
}
