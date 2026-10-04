interface class DataInterface {
  Future<void> saveData(String key, dynamic value);
  Future<dynamic> getData(String key);
  Future<void> deleteData(String key);
}
