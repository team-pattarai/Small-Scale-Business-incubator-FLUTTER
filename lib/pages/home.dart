import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/subpages/category.dart';

class Homepage extends StatelessWidget {
  final List<String> texts = [
    'Profile',
    'Wishlist',
    'F2',
    'F3',
  ];

  final List<Color> color = [
    const Color.fromARGB(255, 85, 236, 241),
  ];
  final List quickLinkIcons = [
    Icons.person_2_rounded,
    Icons.favorite_rounded,
    Icons.details_rounded,
    Icons.contact_page_rounded
  ];
  final List<String> category = [
    "assets/images/catering.jpg",
    "assets/images/tailoring.jpg",
    "assets/images/pottery.jpg",
    "assets/images/handcraft.jpg",
    "assets/images/homedecor.jpg",
    "assets/images/stationary.jpg",
    "assets/images/homecleaning.jpg",
    "assets/images/interior.jpg",
    "assets/images/technical.jpg",
    "assets/images/petcare.jpg",
    "assets/images/spa.jpg",
    "assets/images/catering.jpg"
  ];

  final List<String> collections = [
    'Catering',
    'Tailoring',
    'Pottery',
    'Handcrafted',
    'Home Decor',
    'Gifts',
    'Cleaning',
    'Home Design',
    'Tech',
    'Pet Care',
    'Wellness, Spa',
    'Others',
    // Add more collections as needed
  ];

  final Function(int)? updateIndex;

  Homepage({super.key, this.updateIndex});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Warning',
              textAlign: TextAlign.center,
            ),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => exit(0), // Kill app
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(181, 243, 243, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 390,
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 199, 228, 220),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Businesses",
                    style: TextStyle(
                      color: Color.fromARGB(255, 96, 136, 134),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: collections.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryBasedList(
                                  collectionName: collections[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            height: 75,
                            width: 75,
                            child: Column(
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(37.5),
                                    child: Image.asset(
                                      category[index],
                                      height: 75,
                                    ),
                                  ),
                                ),
                                Text(
                                  collections[index],
                                  style: const TextStyle(),
                                  softWrap: false,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 145,
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: double.maxFinite,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 180, 224, 217),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick links",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 62, 125, 134),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                
                                  updateIndex?.call(3);
                                
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: color[index % color.length],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  quickLinkIcons[index],
                                  size: 35,
                                  color: const Color.fromARGB(255, 54, 70, 78),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                texts[index],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 39, 85, 81),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}