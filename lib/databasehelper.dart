import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseHelper {

  SqfliteDatabaseHelper.internal();
  static final SqfliteDatabaseHelper instance = new SqfliteDatabaseHelper.internal();
  factory SqfliteDatabaseHelper() => instance;

  static final contactinfoTable = 'contactinfoTable';
  static final _version = 1;

  static Database _db;

  Future<Database> get db async {
    if (_db !=null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path,'syncdatabase.db');
    print(dbPath);
    var openDb = await openDatabase(dbPath,version: _version,
    onCreate: (Database db,int version)async{
      await db.execute("""
        CREATE TABLE $contactinfoTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          user_id INTEGER NOT NULL, 
          name TEXT, 
          email TEXT, 
          gender TEXT, 
          created_at TEXT
          )""");
    },
    onUpgrade: (Database db, int oldversion,int newversion)async{
      if (oldversion<newversion) {
        print("Version Upgrade");
      }
    }
    );
    print('db initialize');
    return openDb;
  }

}