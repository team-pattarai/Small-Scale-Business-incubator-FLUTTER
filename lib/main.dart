import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flutter_application_1/components/DrawerItems.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => GeeksforGeeksState();
}

class GeeksforGeeksState extends State<MainScreen> {
  int currentIndex = 0;
  List<Color> containerGradient = [Color.fromARGB(255, 253, 255, 253), Color(0xFF76ABF3)];

  final List<List<Color>> colors = [
    [Color.fromARGB(255, 246, 255, 246), Color(0xFF76ABF3)],
    [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
    [Color(0xFF8CF385), Color(0xFF76ABF3)],
    [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(193, 233, 233, 1),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: .3,
          backgroundColor: Color.fromRGBO(181, 243, 243, 1),
          title: const Text("Project name :)"),
        ),
        drawer: Drawer(
          backgroundColor: Color.fromRGBO(196, 223, 223, 1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(child: const Text("Project Name")),
              const DropDownText(
                  label: "Business", icon: Icons.workspaces_filled, buttonRack: []),
            ],
          ),
        ),
        body: Container(
          height: 475,
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromRGBO(217, 238, 238, 1),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(15),
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
        ),
        bottomNavigationBar: _Navbar(),
      ),
    );
  }

  Widget _Navbar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color.fromRGBO(147, 228, 228, 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 19, 76, 78).withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GNav(
          gap: 8,
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              backgroundGradient: const LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244,1)],
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                  containerGradient = colors[0];
                });
              },
            ),
            GButton(
              icon: Icons.pie_chart,
              text: 'Stats',
              backgroundGradient: const LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244,1)],
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                  containerGradient = colors[1];
                });
              },
            ),
            GButton(
              icon: Icons.manage_history,
              text: 'Orders',
              backgroundGradient: const LinearGradient(
                  colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244,1)],),
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                  containerGradient = colors[2];
                });
              },
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              backgroundGradient: const LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244,1)],
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                  containerGradient = colors[3];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MainScreen());
}
