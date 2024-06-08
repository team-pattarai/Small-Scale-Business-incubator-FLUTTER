// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/business.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_application_1/db/connect.dart';

String title = "";

Future<List<List<String>>> getCompanyList(int index, String collectionName) async {
  title = collectionName;
  var db = await DB.getDB();

  if (db != null) {
    var collection = db.collection("StartUp");
    List<List<String>> categoryValues = [];
    
    final documents = await collection.find().toList();
    for (var doc in documents) {
      if (doc['Category'] == collectionName) {
        List<String> CompDet = [];
        String Name = doc['Name'];
        String Address = doc['Address'];
        String Rating = doc['Rating'].toString();
        String Special = doc['Special'].toString();
        
        CompDet.add(Name);
        CompDet.add(Address);
        CompDet.add(Rating);
        CompDet.add(Special);
        
        categoryValues.add(CompDet);
      }
    }
    return categoryValues;
  }
  return [];
}

class CategoryBasedList extends StatefulWidget {
  final String collectionName;

  const CategoryBasedList({super.key, required this.collectionName});

  @override
  _CategoryBasedListState createState() => _CategoryBasedListState();
}

class _CategoryBasedListState extends State<CategoryBasedList> {
  List<List<String>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var fetchedData = await getCompanyList(0, widget.collectionName);
    setState(() {
      data = fetchedData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                int starCount = 0;
                try {
                  starCount = int.parse(data[index][2]);
                // ignore: empty_catches
                } catch (e) {
                }

                return InkWell(onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => Business(data:data,index:index),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },child:  Container(
                  width: screenWidth,
                  height: 160, // Increase the height to accommodate the review bar
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 151, 207, 205),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16), // Add some spacing
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 16), // Add some spacing
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index][0],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                    ),
                                  ),
                                  Text(
                                    data[index][1],
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 19,
                                    ),
                                  ),
                                  Text(
                                    "Speciality : ${data[index][3]}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16), // Add some spacing
                            const SizedBox(
                              width: 60,
                              height: 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16), // Add some spacing
                          ],
                        ),
                      ),
                      const SizedBox(height: 8), // Add some spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          starCount,
                          (index) => const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 11, 63, 77),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16), // Add some spacing
                    ],
                  ),
              ));
                
              },
            ),
    );
  }
}
