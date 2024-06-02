import 'package:flutter_application_1/db/connect.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<List<Map<String, dynamic>>> findByName(String name, Db db) async {
  var collection = db.collection("UserManagerment");
  final results = await collection.find(where.eq('user', name.toString())).toList();
  return results;
}
Future<int> loginin(String username, String password) async {
  var db = await DB.getDB();  // Make sure DB.getDB() correctly opens the connection

  if (db != null) {
    List<Map<String, dynamic>> users = await findByName(username, db);
    if (users.isNotEmpty) {
      // Assuming password is stored in plaintext (not recommended), verify password
      var user = users.first;
      if (user['passkey'] == password) {
        if (user['init']== 'false' && user['mode']=='Seller'){
          return 2;
        }
        return 0;
      }
    }
  }
  return 1;
}
String password_gen(String passkey){
  return passkey;
}
Future<bool> Signupup(String username, String password,String email,String mode,String confpassword) async {
  var db = await DB.getDB();  
  if (db != null) {
    List<Map<String, dynamic>> users = await findByName(email,db);
    if (users ==[]){
       if(password==confpassword) {
      var collection = db.collection("UserManagerment");
    await collection.insert({
      'user': email,
      'passkey': password_gen(password),
      'mode' : mode,
      'init': 'false'
    });
    return true;
    }
    }
    else {
      return false;
    }
  }
  return false;
}