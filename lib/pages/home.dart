import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

// ignore: must_be_immutable
class Homepage extends StatelessWidget {

  List<String> texts = [
  'Profile',
  'F1',
  'F2',
  'F3',
];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 390,
          width: double.infinity,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 253, 255, 253),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Businesses",
                style: TextStyle(
                  color: Color.fromARGB(255, 96, 136, 134),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: List.generate(
                    12,
                    (index) => Container(
                      padding: EdgeInsets.all(10),
                      height: 75,
                      width: 75,
                      color: Color.fromRGBO(248, 246, 244, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 137,
          margin: EdgeInsets.only(left: 15,right: 15),
          width: double.maxFinite,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 250, 255, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quick links",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 106, 140, 145)),),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            style: TextStyle(
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
