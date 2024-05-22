import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/subpages/category.dart';
// ignore: must_be_immutable
class Homepage extends StatelessWidget {

  List<String> texts = [
  'Profile',
  'F1',
  'F2',
  'F3',
];  List<Color> color = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  final List<String> collections = [
    'philo',
    'sasidaran',
    'collection3',
    'collection4',
        'sasidaran',
    'collection3',
    'collection4',
        'sasidaran',
    'collection3',
    'collection4',
        'sasidaran',
    'collection3',
    'collection4',
    // Add more collections as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 390,
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 253, 255, 253),
              borderRadius: BorderRadius.circular(10)),
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
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: List.generate(
                    12,

                    (index) => GestureDetector(
            onTap: () {
              // Call a function or navigate to a new widget with the index
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryBasedList(collectionName: collections[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 75,
              width: 75,
              color: const Color.fromRGBO(248, 246, 244, 1),
            ),
          ),
        
                    
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 137,
          margin: const EdgeInsets.only(left: 15,right: 15),
          width: double.maxFinite,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 250, 255, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Quick links",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 106, 140, 145)),),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  children: List.generate(
  4,
  (index) => Container(
    width: double.maxFinite,
    child: Column(
      children: [Container(height: 70,width: 70 ,decoration: BoxDecoration(color: color[2], shape: BoxShape.circle),),
        Center(
          child: Text(
            texts[index], // Set the text for each container
            style: const TextStyle(
              color: Color.fromARGB(255, 52, 185, 174),
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  ),
),
                ),
              ),],),
        ),
        
      ],
    );
  }
}
