import 'package:holiday2/helpers/Database.dart';
import 'package:holiday2/models/SettingsModel.dart';
import 'package:sqflite/sqflite.dart';

class SettingsProvider {
  Future<Database> getInstance() async {
    var db = await DatabaseHelper.instance.database;
    return db;
  }

  Future<SettingsModel> insert(SettingsModel item) async {
    item.id =
        await (await getInstance()).insert(SettingsModel_table, item.toMap());
    return item;
  }

  Future<SettingsModel> byId(int id) async {
    List<Map> result = await (await getInstance()).query(SettingsModel_table,
        where: '$SettingsModel_column_id = ?', whereArgs: [id]);

    return result.length > 0 ? new SettingsModel.fromMap(result.first) : null;
  }

  Future<List> all() async {
    var result = await (await getInstance())
        .query(SettingsModel_table, orderBy: '$SettingsModel_column_id DESC');

    return result.toList();
  }

  Future<int> delete(int id) async {
    return await (await getInstance()).delete(SettingsModel_table,
        where: '$SettingsModel_column_id = ?', whereArgs: [id]);
  }
}
