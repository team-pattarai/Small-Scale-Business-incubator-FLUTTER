import 'package:flutter_application_1/db/connect.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<List<Map<String, dynamic>>> findByName(String name, Db db) async {
  var collection = db.collection("UserManagerment");
  final results = await collection.find(where.eq('user', name.toString())).toList();
  print(results);
  return results;
}
Future<bool> loginin(String username, String password) async {
  var db = await DB.getDB();  // Make sure DB.getDB() correctly opens the connection

  if (db != null) {
    List<Map<String, dynamic>> users = await findByName(username, db);
    if (users.isNotEmpty) {
      // Assuming password is stored in plaintext (not recommended), verify password
      var user = users.first;
      if (user['passkey'] == password) {
        return true;
      }
    }
  }
  return false;
}