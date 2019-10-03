import 'package:holiday2/helpers/Database.dart';
import 'package:holiday2/models/ItemModel.dart';
import 'package:sqflite/sqflite.dart';

class ItemProvider {
  Future<Database> getInstance() async {
    var db = await DatabaseHelper.instance.database;
    return db;
  }

  Future<ItemModel> insert(ItemModel item) async {
    item.id = await (await getInstance()).insert(ItemModel_table, item.toMap());
    return item;
  }

  Future<List> all() async {
    var result = await (await getInstance()).query(ItemModel_table, orderBy: '$ItemModel_column_dateFrom DESC');
    
    return result.toList();
  }

  Future<int> delete(int id) async {
    return await (await getInstance()).delete(ItemModel_table, where: '$ItemModel_column_id = ?', whereArgs: [id]);
  }

}