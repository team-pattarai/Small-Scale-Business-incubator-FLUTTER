import 'package:flutter/material.dart';

import 'package:flutter_application_1/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String username = 'Username';


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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NAME",
                        style: TextStyle(fontSize: 32),
                      ),
                      Text("SOME OTHER"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // New container below the profile information
        Container(
          height: 350,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              " QUICK LINKS AND OTHERS",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
