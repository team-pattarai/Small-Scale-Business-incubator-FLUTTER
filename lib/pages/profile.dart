import 'package:flutter/material.dart';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
String Name="";
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String username = 'Username';
  final storage = const FlutterSecureStorage();
  String Addy="";

  @override
  void initState() {
    super.initState();
    _readFromSecureStorage();
  }

  Future<void> _readFromSecureStorage() async {
    Name = (await storage.read(key: "Name"))!;
    Addy = (await storage.read(key: 'Addy'))!;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 225,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color[2],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  color: color[0],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 159, 217, 221),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Name,
                        style: const TextStyle(fontSize: 32),
                      ),
                      Text(Addy),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // New container below the profile information
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(80, 96, 125, 139),
            borderRadius: BorderRadius.circular(10),
          ),
          child: HorizontalSnapList()
        ),
      ],
    );
  }
}
class HorizontalSnapList extends StatefulWidget {
  @override
  _HorizontalSnapListState createState() => _HorizontalSnapListState();
}

class _HorizontalSnapListState extends State<HorizontalSnapList> {
  late PageController _pageController;
  bool _isLoading = true;
  List<List<List<String>>> _colors = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
    _fetchColors();
  }

  Future<void> _fetchColors() async {

    // Replace this with your data and index
    List<List<String>> data = [[Name]];
    int index = 0;

    List<List<List<String>>> colors = await fetchColors(data, index);
    setState(() {
      _colors = colors;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '-> SERVICES <-',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        _isLoading
            ? const SizedBox(
              height: 300,
              child: Center(
                  child: CircularProgressIndicator(),
                ),
            )
            : SizedBox(
                height: 300,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _colors[1].length,
                  itemBuilder: (BuildContext context, int index) {
                    final List<String> serviceData = _colors[1][index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(87, 96, 125, 139),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 80,
                              child: Icon(Icons.food_bank_rounded),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    serviceData[0],
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  Text(
                                    "Quantity : ${serviceData[1]}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Price : ${serviceData[2]}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Description : ${serviceData.length > 3 ? serviceData[3] : ''}",
                                    style: const TextStyle(fontSize: 16),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}