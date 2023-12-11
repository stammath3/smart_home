import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../data/user.dart';



class DatabaseHelper{
   static Future<sql.Database> database() async {
    //δημιουργια βασης αν δεν υπαρχει
    final dbPath = await sql
        .getDatabasesPath(); //to path αναλογα android/iOS επιστρεφει ενα future γιαυτο εχουμε βαλει το await.
    return sql.openDatabase(
      path.join(dbPath, 'mydb.db'),
      version: 1,
      onCreate: _createDB,
    ); //αν υπαρχει το αρχειο ανοιγει την βαση διαφορετικα την δημιουργει
  }

  static Future _createDB(db, version) async {
    await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          country TEXT NOT NULL, 
          fullname TEXT NOT NULL,
          email TEXT NOT NULL, 
          password TEXT NOT NULL
          )''');
  }
  
  static Future<void> insert(String table, Map<String, Object> data) async {
    print(data); //τυπωνω τα δεδομένα για να δω οτι ειναι σωστά
    final db = await DatabaseHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    //με το await εδω περιμενουμε να τελειωσουν ολες οι διαδικασιες στην συναρτηση insert
  }

  static Future<void> deleteAll() async {
    final db = await DatabaseHelper.database();
    db.execute('Delete from users;');
  }

   static Future<List<Map<String, dynamic>>> getData(table) async {
    final db = await DatabaseHelper.database();
    return db.query(table); //επιστρεφει μια λιστα απο maps
  }
  static Future<User?> readUser(String email, String password) async {
    final db = await DatabaseHelper.database();

    final maps = await db.query(
      'users',
      columns: UserFields.values,
      where: '${UserFields.email} = ? AND ${UserFields.password} = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      print("User $email not found");
      return null;
    }
  }

  static Future<int?> readUsersId(String email, String password) async {
    final db = await DatabaseHelper.database();

    final maps = await db.query(
      'users',
      columns: ['id'],
      where: '${UserFields.email} = ? AND ${UserFields.password} = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      var x = maps[0]['id'];
      return x as int;
    } else {
      return null;
    }
  }

  static Future<void> updateUser(String table, User user, int id) async {
    final db = await DatabaseHelper.database();
    db.update(table, user.toMap(), where: 'id = ?', whereArgs: [id]);
    //με το await εδω περιμενουμε να τελειωσουν ολες οι διαδικασιες στην συναρτηση insert
  }
} 