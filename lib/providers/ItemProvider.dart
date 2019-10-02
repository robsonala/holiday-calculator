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
    var result = await (await getInstance()).query(ItemModel_table);
    
    return result.toList();
  }

}