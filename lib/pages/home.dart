import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 475,
      width: double.infinity,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 253, 255, 253),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(15),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
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
    );
  }
}
