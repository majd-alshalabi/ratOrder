import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnEmail = '_email';
  static final columnPassword = '_password';
  static final columnFav = '_fav';

  static Future<Database> getDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnEmail TEXT, $columnPassword TEXT,$columnFav TEXT)');
      },
    );
  }

  static Future<void> addRowToDataBase(
      String email, String password, String fav) async {
    Database database = await getDatabase();
    await database.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO $table ($columnEmail, $columnPassword,$columnFav) VALUES("$email" , "$password" , "$fav")');
      },
    );
  }

  static Future<List<Map>> getDataBaseInfo() async {
    return getDatabase().then((database) async {
      List<Map> list = await database.rawQuery('SELECT * FROM $table');
      return list;
    });
  }

  static Future<void> updateFav(int id, String fav) {
    getDatabase().then((database) {
      database.rawUpdate(
          'UPDATE $table SET $columnFav = "$fav" WHERE $columnId = $id');
    });
    return null;
  }

  static Future<int> getTheTableRowNum() {
    return getDatabase().then((database) async {
      List<Map> list = await database.rawQuery('SELECT * FROM $table');
      return list.length;
    });
  }
}
