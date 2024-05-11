import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flutter_application_1/components/DrawerItems.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/business.dart'; 
import 'package:flutter_application_1/pages/orders.dart'; 
import 'package:flutter_application_1/pages/home.dart';


// COLORS
final List color=[Color.fromRGBO(193, 233, 233, 1),Color.fromRGBO(181, 243, 243, 1),Color.fromRGBO(196, 223, 223, 1)];


class MainScreenBody extends StatefulWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  int currentIndex = 0;


  final List pages=[Homepage(),Homepage(),Orders(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      backgroundColor: Color.fromRGBO(193, 233, 233, 1),
      appBar: AppBar(
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        elevation: .3,
        backgroundColor: Color.fromRGBO(181, 243, 243, 1),
        title: Text("Project name :)"),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(196, 223, 223, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("Project Name")),
            DropDownText(
                label: "Business", icon: Icons.workspaces_filled, buttonRack: []),
          ],
        ),
      ),
      body: pages[currentIndex], 
      bottomNavigationBar: _Navbar(
        currentIndex: currentIndex,
        onIndexChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    )
    );
  }
}


class _Navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const _Navbar({
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GNav(
          gap: 8,
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              backgroundGradient: LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(0),
            ),
            GButton(
              icon: Icons.pie_chart,
              text: 'Stats',
              backgroundGradient: LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(1),
            ),
            GButton(
              icon: Icons.manage_history,
              text: 'Orders',
              backgroundGradient: LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(2),
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              backgroundGradient: LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(3),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp( MainScreenBody());
}
