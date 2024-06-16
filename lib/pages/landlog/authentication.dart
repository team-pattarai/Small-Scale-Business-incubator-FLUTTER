import 'dart:async';
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
        addsession(username);
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
}Future<bool> Signupup(String username, String password, String email, String mode, String confPassword) async {
  
  try {
    var db = await DB.getDB();
    if (db == null) {

      return false;
    }
    

    
    List<Map<String, dynamic>> users = await findByName(email, db);

    
    if (users.isEmpty) {
      if (password == confPassword) {

        
        var collection = db.collection("UserManagerment");
        await collection.insert({
          'user': email,
          'passkey': password_gen(password),
          'mode': mode,
          'init': 'false'
        });
        

        return true;
      } else {

      }
    } else {

    }
  } catch (e) {

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
Future<bool> addOrder(List counter,List services,String companyName) async {
   try {
    var db = await DB.getDB();
    if (db == null) {

      return false;
    }
    List<List<dynamic>> orders =[];
    var collection = db.collection("Orders");
    for(int i=0;i<counter.length;i++){
      List tempList=[];
      if(counter[i]!=0){
        tempList.add(services[i][0]);
        tempList.add(counter[i]);
        orders.add(tempList); 
      }
    }
    await collection.insert({
      "to":companyName,
      "from":"userr",
      "orders":orders,
      "status":"ongoing"
    });
    return true;
   }
   catch(e){
    return false;
   }
}

Future<List<Map<String, dynamic>>> fetchOrders() async {
  var db = await DB.getDB();
  List<Map<String, dynamic>> ordersList = [];

  if (db != null) {
    var collection = db.collection("Orders");
    final results = await collection.find().toList();

    for (var order in results) {
      ordersList.add(order);
    }
  }

  return ordersList;
}

Future<bool> markDone(Map<String, dynamic> order) async {
  try {
    var db = await DB.getDB();
    if (db == null) {
      return false;
    }

    var collection = db.collection("Orders");
    var result = await collection.update(
      where.eq('_id', order['_id']),
      modify.set('status', 'completed')
    );

    if (result['nModified'] == 1) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

void addsession(String username,){

}