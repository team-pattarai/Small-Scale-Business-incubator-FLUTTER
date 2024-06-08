import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Map<String, dynamic>> ongoingOrders = [];
  List<Map<String, dynamic>> completedOrders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders().then((orders) {
      setState(() {
        ongoingOrders = orders.where((order) => order['status'] == 'ongoing').toList();
        completedOrders = orders.where((order) => order['status'] == 'completed').toList();
      });
    });
  }

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
          children: [
            OrderListView(orders: ongoingOrders),
            OrderListView(orders: completedOrders),
          ],
        ),
          ),);

  }}

class OrderListView extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        var order = orders[index];
        print(orders);
        return Container(
          height: 100,
          padding: const EdgeInsets.all(10),
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
                    order['to'] ?? 'No Name',
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text('Date: ${order['date'] ?? 'No Date'}'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
