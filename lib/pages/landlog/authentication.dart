import 'package:flutter_application_1/db/connect.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<List<Map<String, dynamic>>> findByName(String name, Db db) async {
  var collection = db.collection("UserManagerment");
  final results = await collection.find(where.eq('user', name.toString())).toList();
  return results;
}
Future<int> loginin(String username, String password) async {
  var db = await DB.getDB();  

  if (db != null) {
    List<Map<String, dynamic>> users = await findByName(username, db);
    if (users.isNotEmpty) {
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
Future<bool> Configure(String name,String addy,String category,List services,String Email,String Speciality) async {
  var db = await DB.getDB();  
  if (db != null) { 
    var collection = db.collection("StartUp");
    await collection.insert({
      'Name':name,
      'Address':addy,
      'Category':category,
      'Services':services,
      'Rating':"0",
      'Special':Speciality
    });
    var collection1 = db.collection("UserManagerment");
    var selector = where.eq('user', Email); 
    var modifier = modify.set('init', 'true'); 
    await collection1.update(selector, modifier);
    return true;

  }
  return false;
}
Future<List<List<List<String>>>> fetchColors(List<List<String>> data, int index) async {
  var db = await DB.getDB();
  List<List<List<String>>> returnService = [];

  if (db != null) {
    var collection = db.collection("StartUp");
    final results = await collection.find(where.eq("Name", data[index][0])).toList();
    List servicesAll = results[0]["Services"];
    List<List<String>> discounts = [];
    List<List<String>> services = [];

    for (int i = 0; i < servicesAll.length; i++) {
      List<String> discount = [
        servicesAll[i][4].toString(),
        servicesAll[i][0].toString()
      ];
      discounts.add(discount);

      List<String> tempList = [
        servicesAll[i][0].toString(),
        servicesAll[i][1].toString(),
        servicesAll[i][2].toString(),
        servicesAll[i][3].toString()
      ];
      services.add(tempList);
    }
    returnService.add(discounts);
    returnService.add(services);
  }

  return returnService;
}
