import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/landlog/landing.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flutter_application_1/components/DrawerItems.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/orders.dart'; 
import 'package:flutter_application_1/pages/home.dart';


final List color=[const Color.fromRGBO(193, 233, 233, 1),const Color.fromRGBO(181, 243, 243, 1),const Color.fromRGBO(196, 223, 223, 1)];

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
class MainScreenBody extends StatefulWidget {
  const MainScreenBody({super.key});

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  int currentIndex = 0;


  final List pages=[Homepage(),Homepage(),Orders(), const ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(193, 233, 233, 1),
      appBar: 
      AppBar(
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        elevation: .3,
        backgroundColor: const Color.fromRGBO(181, 243, 243, 1),
        title: const Text("Project name :)"),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(196, 223, 223, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
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
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(147, 228, 228, 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 19, 76, 78).withOpacity(0.2),
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
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(0),
            ),
            GButton(
              icon: Icons.pie_chart,
              text: 'Stats',
              backgroundGradient: const LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(1),
            ),
            GButton(
              icon: Icons.manage_history,
              text: 'Orders',
              backgroundGradient: const LinearGradient(
                colors: [Color.fromRGBO(181, 243, 243, 1), Color.fromRGBO(248, 246, 244, 1)],
              ),
              onPressed: () => onIndexChanged(2),
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              backgroundGradient: const LinearGradient(
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
  runApp( const Landing());
}
