import 'package:flutterdevicefeatures_miniproject/core/services/data/data_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData implements DataInterface {
  final SharedPreferences _prefs;
  static LocalData? _instance;

  LocalData._(this._prefs);

  static Future<LocalData> instance() async {
    if (_instance == null) {
      _instance = LocalData._(await SharedPreferences.getInstance());
    }
    return _instance!;
  }

  @override
  Future<void> saveData(String key, dynamic value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<dynamic> getData(String key) async {
    return await _prefs.getString(key);
  }

  @override
  Future<void> deleteData(String key) async {
    await _prefs.remove(key);
  }
}