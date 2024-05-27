import 'package:flutter/material.dart';

import 'package:flutter_application_1/main.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<String> orders = ["Order 1", "Order 2", "Order 3"]; // Sample orders list


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: color[1],
        appBar: 
          const TabBar(
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [Text("Ongoing.. "),
                  Tab(icon: Icon(Icons.incomplete_circle_outlined)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Completed "),
                  Tab(icon: Icon(Icons.done_all_outlined)),
                ],
              ),
            ],
          ),






        body: TabBarView(
          children: [ListView.builder(
  itemCount: orders.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        
        children: [
          Expanded(
            child: ListTile(
            
              title: Text(
                orders[index],
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 20), // Adjust the width as needed for spacing
          const Text("Date : 12/05/2024"),
        ],
      ),
    );
  },
),









            ListView.builder(
  itemCount: orders.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                orders[index],
                style:   const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 20), // Adjust the width as needed for spacing
          const Text("Date : 12/05/2024"),
        ],
      ),
    );
  },
),
          ],
        ),
      ),
    );
  }
}
