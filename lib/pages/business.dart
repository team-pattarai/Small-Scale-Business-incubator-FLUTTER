import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitality/vitality.dart';

double height = 0;

class Business extends StatefulWidget {
  final List<List<String>> data;
  final int index;

  const Business({super.key, required this.data, required this.index});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  List<List<List<String>>> colors = [];
  List<int> counter = [];

  @override
  void initState() {
    super.initState();
    fetchColors(widget.data, widget.index).then((fetchedColors) {
      setState(() {
        colors = fetchedColors;
        // Generate counter list dynamically
        counter = List<int>.filled(fetchedColors[1].length, 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text(widget.data[widget.index][0])),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.heart_broken_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlueGreyContainer(data: widget.data[widget.index]),
            const SizedBox(height: 20),
            if (colors.isEmpty)
              const Center(
                child: SpinKitFadingCube(
                  color: Colors.blue,
                  size: 50.0,
                ),
              )
            else
              HorizontalSnapList(colors: colors, counter: counter, incrementCount: incrementCount, decrementCount: decrementCount),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void incrementCount(int index) {
    setState(() {
      counter[index]++;
    });
  }

  void decrementCount(int index) {
    setState(() {
      if (counter[index] > 0) counter[index]--;
    });
  }
}

class BlueGreyContainer extends StatelessWidget {
  final List<String> data;

  const BlueGreyContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Text(data[1], style: const TextStyle(fontSize: 18), maxLines: 2),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              int.parse(data[2]),
              (index) => const Icon(
                Icons.star,
                color: Color.fromARGB(255, 11, 63, 77),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalSnapList extends StatefulWidget {
  final List<List<List<String>>> colors;
  final List<int> counter;
  final Function(int) incrementCount;
  final Function(int) decrementCount;

  const HorizontalSnapList({super.key, 
    required this.colors,
    required this.counter,
    required this.incrementCount,
    required this.decrementCount,
  });

  @override
  _HorizontalSnapListState createState() => _HorizontalSnapListState();
}

class _HorizontalSnapListState extends State<HorizontalSnapList> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * .08,
          width: double.maxFinite,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            itemCount: widget.colors[0].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(87, 96, 125, 139),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: double.maxFinite,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 6),
                      child: Icon(Icons.discount_rounded),
                    ),
                    Text(
                      "${widget.colors[0][index][0]}%",
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        widget.colors[0][index][1],
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Text(
          '-> SERVICES <-',
          style: TextStyle(fontSize: height * .025.toDouble(), fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: height * .531,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: widget.colors[1].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(87, 96, 125, 139),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 80,
                        child: Icon(Icons.food_bank_rounded),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.colors[1][index][0],
                              style: const TextStyle(fontSize: 22),
                            ),
                            Text(
                              "Quantity : ${widget.colors[1][index][1]}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Price : ${widget.colors[1][index][2]}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Description : ${widget.colors[1][index][3]}",
                              style: const TextStyle(fontSize: 16),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 172, 199, 191),
                                border: Border.all(color: Colors.black, width: 1.5),
                              ),
                              height: 30,
                              width: 90,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => widget.decrementCount(index),
                                    child: const SizedBox(
                                      width: 30,
                                      child: Icon(Icons.exposure_minus_1_rounded),
                                    ),
                                  ),
                                  Container(width: 1.5, color: Colors.black),
                                  const Spacer(),
                                  const SizedBox(width: 4),
                                  Center(
                                    child: SizedBox(
                                      width: 20,
                                      child: Text(
                                        widget.counter[index].toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(width: 1.5, color: Colors.black),
                                  InkWell(
                                    onTap: () => widget.incrementCount(index),
                                    child: const SizedBox(
                                      width: 30,
                                      child: Icon(Icons.plus_one_rounded),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 115,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _addService(context),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 5),
                        Center(child: Icon(Icons.shopping_cart_checkout_rounded)),
                        Spacer(),
                        Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



Widget _addService(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Vitality.randomly(
          background: Colors.white,
          maxOpacity: 0.8,
          minOpacity: 0.3,
          itemsCount: 80,
          enableXMovements: false,
          whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
          maxSpeed: 1.5,
          maxSize: 30,
          minSpeed: 0.5,
          randomItemsColors: const [Color.fromARGB(255, 28, 88, 85), Color.fromARGB(255, 37, 64, 99)],
          randomItemsBehaviours: [
            ItemBehaviour(shape: ShapeType.Icon, icon: Icons.send_rounded),
          ],
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.send_and_archive_rounded,
                size: 200,
                color: Color.fromARGB(255, 79, 99, 109),
              ),
              const Text(
                'Order Sent To Seller.!!',
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 55, 78, 90),
                ),
              ),
              SizedBox(height: height*.031,),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const MainScreenBody(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                ),
                child: Container(
                width: double.maxFinite,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: height*.14),
                decoration: BoxDecoration(color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(25)),
                child: Row(
                  
                  children: [
                    SizedBox(width: height*.015,),
                    Center(child: Icon(Icons.home_rounded,size: height*.045,)),
                    const Spacer(),
                    Center(child: Text("H O M E",style: TextStyle(fontSize: height*.032,fontWeight:FontWeight.bold ),)),
                    SizedBox(width: height*.015,)
                  ],
                ),
              ),
              )
              
            ],
          ),
        ),
      ],
    ),
  );
}
