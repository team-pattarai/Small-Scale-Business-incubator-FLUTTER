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
    fetchAndUpdateOrders();
  }

  Future<void> fetchAndUpdateOrders() async {
    var orders = await fetchOrders();
    setState(() {
      ongoingOrders = orders.where((order) => order['status'] == 'ongoing').toList();
      completedOrders = orders.where((order) => order['status'] == 'completed').toList();
    });
  }

  ScaffoldFeatureController _warningBubble() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SizedBox(
          height: 200,
          child: Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 199, 200, 227),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Mark as Done Failed',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Capriola',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        duration: const Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
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
            OrderListView(
              orders: ongoingOrders,
              refreshOrders: fetchAndUpdateOrders,
              showWarning: _warningBubble,
            ),
            OrderListView(
              orders: completedOrders,
              refreshOrders: fetchAndUpdateOrders,
              showWarning: _warningBubble,
            ),
          ],
        ),
          ),);
  }
}

class OrderListView extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final Future<void> Function() refreshOrders;
  final ScaffoldFeatureController Function() showWarning;

  const OrderListView({
    super.key,
    required this.orders,
    required this.refreshOrders,
    required this.showWarning,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        var order = orders[index];
        return Container(
          width: double.maxFinite,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        order['to'] ?? 'No Name',
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text('Date: ${order['date'] ?? 'No Date'}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 12),
                      child: Text(
                        'Orders: ${order['orders'][0][0] ?? 'No Orders'} x ${order['orders'][0][1]} ..etc',
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if (await markDone(order)) {
                    await refreshOrders();
                  } else {
                    showWarning();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.done_rounded,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

