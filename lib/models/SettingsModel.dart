final String SettingsModel_table = 'settings';
final String SettingsModel_column_id = 'id';
final String SettingsModel_column_key = 'key';
final String SettingsModel_column_value = 'value';

class SettingsModel {
  int id;
  String key;
  String value;

  SettingsModel(this.key, this.value);

  // convenience constructor to create a Word object
  SettingsModel.fromMap(Map<String, dynamic> map) {
    id = map[SettingsModel_column_id];
    key = map[SettingsModel_column_key];
    value = map[SettingsModel_column_value];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      SettingsModel_column_key: key,
      SettingsModel_column_value: value
    };

    if (id != null) {
      map[SettingsModel_column_id] = id;
    }
    
    return map;
  }
}
