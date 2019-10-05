final String SettingsModel_table = 'settings';
final String SettingsModel_column_key = 'key';
final String SettingsModel_column_value = 'value';

class SettingsModel {
  String key;
  String value;

  SettingsModel(this.key, this.value);

  // convenience constructor to create a Word object
  SettingsModel.fromMap(Map<String, dynamic> map) {
    key = map[SettingsModel_column_key];
    value = map[SettingsModel_column_value];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      SettingsModel_column_key: key,
      SettingsModel_column_value: value
    };
    
    return map;
  }
}
