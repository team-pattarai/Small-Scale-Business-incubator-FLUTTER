import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Business extends StatefulWidget {
  final List<List<String>> data;
  final int index;

  const Business({required this.data, required this.index});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  final List<List<String>> colors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text(widget.data[widget.index][0])),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.heart_broken_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlueGreyContainer(data: widget.data[widget.index]),
            SizedBox(height: 20),
            FutureBuilder<List<List<List<String>>>>(
              future: fetchColors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCube(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return HorizontalSnapList(colors: snapshot.data!);
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<List<List<List<String>>>> fetchColors() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating a 2-second delay
    return [
      [
        ["50", "discount 1"],
        ["10", "discount 2"],
        ["30", "discount 3"],
        ["20", "discount 4"],
      ],
      [
        ['fdgdfhsfdgdfsfdfsfsd', '111', '1111', 'awuffys sudyfsdbfis  fesbd uefbaueybfwrus s uyb grsusyfug szuv ervjhrw sub rw'],
        ['ser2', '111', '1111', 'sigeuf sdiyfbsd seifdbs sdudsd sidf sdikbsd sidgb sdxikshvd f sjhvfs'],
        ['ser3', '111', '1111', 'dfsgsf sdh g gf fg hsa f srfg ddvy yx vxfg hvh fysg gvftehd dv4yed bg rfv e bn'],
        ['ser4', '111', '1111', 'sdb v jv jy jhyt fjh dfutf i utf iru tuitf iu tkf uyjc ytgvbhj rextcfyvgbu redctv yb5edrtfvy'],
      ]
    ];
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
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Text(data[1], style: TextStyle(fontSize: 18), maxLines: 2),
          SizedBox(height: 10),
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
  List<int> counter = [1, 2, 3, 4];

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
        Container(
          height: 90,
          width: double.maxFinite,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            itemCount: widget.colors[0].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 96, 125, 139),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 6),
                      child: Icon(Icons.discount_rounded),
                    ),
                    Text(
                      widget.colors[0][index][0] + "%",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        widget.colors[0][index][1],
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
        ),
        Container(
          height: 500, // Set a specific height
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: widget.colors[1].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 96, 125, 139),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
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
                              "Quantity : " + widget.colors[1][index][1],
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
                                    child: Container(
                                      width: 30,
                                      child: const Icon(Icons.exposure_minus_1_rounded),
                                    ),
                                  ),
                                  Container(width: 1.5, color: Colors.black),
                                  const Spacer(),
                                  const SizedBox(width: 4),
                                  Center(
                                    child: Container(
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
                                    child: Container(
                                      width: 30,
                                      child: const Icon(Icons.plus_one_rounded),
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
