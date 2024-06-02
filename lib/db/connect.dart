import 'package:mongo_dart/mongo_dart.dart' show Db;

class DB {
  static Db? _db;
  static String _getConnectionString() {
    return "mongodb+srv://maintainer_philix:qwertyuiop@carbonpi.hiozz58.mongodb.net/SB_Incubator?retryWrites=true&w=majority";
  }

  static Future<Db?> getDB() async {
    try {
      if (_db == null) {
        _db = await Db.create(_getConnectionString());
        await _db?.open();
      }
      if (_db != null && _db?.isConnected == true) {
        return _db;
      }
      await _db?.close();
      await _db?.open();
      if (_db != null && _db?.isConnected == true) {
        return _db;
      }
    } catch (e) {
      getDB();
    }
    return null;
  }
}