import 'package:holiday2/models/ItemModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _name = "holiday2.db";
  static final _version = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _name);

    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              DROP TABLE IF EXISTS $ItemModel_table; 
              CREATE TABLE $ItemModel_table (
                $ItemModel_column_id INTEGER PRIMARY KEY,
                $ItemModel_column_title TEXT NOT NULL,
                $ItemModel_column_dateFrom TIMESTAMP NOT NULL,
                $ItemModel_column_dateTo TIMESTAMP NOT NULL
              );
              
              ''');
  }
}
