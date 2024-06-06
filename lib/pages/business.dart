import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Business extends StatefulWidget {
  final List<List<String>> data;
  final int index;

  const Business({required this.data, required this.index});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  List<List<List<String>>> colors = [];

  @override
  void initState() {
    super.initState();
    fetchColors(widget.data, widget.index).then((fetchedColors) {
      setState(() {
        colors = fetchedColors;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              HorizontalSnapList(colors: colors),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BlueGreyContainer extends StatelessWidget {
  final List<String> data;

  const BlueGreyContainer({required this.data});

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

  HorizontalSnapList({required this.colors});

  @override
  _HorizontalSnapListState createState() => _HorizontalSnapListState();
}

class _HorizontalSnapListState extends State<HorizontalSnapList> {
  late PageController _pageController;
  List<int> counter = [0, 0, 0, 0];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          width: double.maxFinite,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            itemCount: widget.colors[0].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        const Text(
          '-> SERVICES <-',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 500, // Set a specific height
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
                                    onTap: () => decrementCount(index),
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
                                        counter[index].toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(width: 1.5, color: Colors.black),
                                  InkWell(
                                    onTap: () => incrementCount(index),
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
      ],
    );
  }
}
