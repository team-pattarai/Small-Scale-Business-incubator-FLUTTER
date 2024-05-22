// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_application_1/db/connect.dart';

Future<List> getCompanyList(int index, String collectionName) async {
  var db = await DB.getDB();
  print(index);
  if (db != null) {
    var collection = db.collection(collectionName);
    List<String> categoryValues = [];
    final documents = await collection.find().toList();
    for (var doc in documents) {
      String category = doc['category'];
      categoryValues.add(category);
    }
    return categoryValues;
  }
  return [];
}

class CategoryBasedList extends StatefulWidget {
  final String collectionName;

  CategoryBasedList({required this.collectionName});

  @override
  _CategoryBasedListState createState() => _CategoryBasedListState();
}

class _CategoryBasedListState extends State<CategoryBasedList> {
  List<dynamic> data = [];
  bool isLoading = true;
  
  get categoryValues => null;

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
      title: const Text('Category'),
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
              return Container(
                width: screenWidth,
                height: 160, // Increase the height to accommodate the review bar
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 151, 207, 205),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16), // Add some spacing
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 16), // Add some spacing
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                data[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(), // Pushes the profile photo to the right
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
                        5,
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
              );
            },
          ),
  );
}
}
