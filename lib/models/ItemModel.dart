final String ItemModel_table = 'items';
final String ItemModel_column_id = 'id';
final String ItemModel_column_title = 'title';
final String ItemModel_column_dateFrom = 'date_from';
final String ItemModel_column_dateTo = 'date_to';

class ItemModel {
  int id;
  String title;
  int dateFrom;
  int dateTo;

  ItemModel();

  // convenience constructor to create a Word object
  ItemModel.fromMap(Map<String, dynamic> map) {
    id = map[ItemModel_column_id];
    title = map[ItemModel_column_title];
    dateFrom = map[ItemModel_column_dateFrom];
    dateTo = map[ItemModel_column_dateFrom];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ItemModel_column_title: title,
      ItemModel_column_dateFrom: dateFrom,
      ItemModel_column_dateTo: dateTo
    };

    if (id != null) {
      map[ItemModel_column_id] = id;
    }
    
    return map;
  }
}
