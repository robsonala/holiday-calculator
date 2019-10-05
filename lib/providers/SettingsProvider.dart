import 'package:holiday2/helpers/Database.dart';
import 'package:holiday2/models/SettingsModel.dart';
import 'package:sqflite/sqflite.dart';

class SettingsProvider {
  Future<Database> getInstance() async {
    var db = await DatabaseHelper.instance.database;
    return db;
  }

  Future<SettingsModel> insert(SettingsModel item) async {
    await (await getInstance()).insert(SettingsModel_table, item.toMap());
    return item;
  }

  Future<SettingsModel> byKey(String key) async {
    List<Map> result = await (await getInstance()).rawQuery('''
        SELECT * FROM $SettingsModel_table
        WHERE $SettingsModel_column_key = '$key'
      ''');
    return result.length > 0 ? new SettingsModel.fromMap(result.first) : null;
  }

  Future<List> all() async {
    var result = await (await getInstance())
        .query(SettingsModel_table, orderBy: '$SettingsModel_column_key DESC');

    return result.toList();
  }
}
