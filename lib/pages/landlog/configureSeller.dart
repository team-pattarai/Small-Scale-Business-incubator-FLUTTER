import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';

class ConfigurePage extends StatefulWidget {
  const ConfigurePage({super.key});

  @override
  State<ConfigurePage> createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _speciality = TextEditingController();
  String? _selectedCategory;
  final List<String> _options = [
    'Catering',
    'Tailoring',
    'Pottery',
    'Handcrafted',
    'Home Decor',
    'Gifts',
    'Cleaning',
    'Home Design',
    'Tech',
    'Pet Care',
    'Wellness, Spa',
    'Others',
    // Add more collections as needed
  ];



  List<List<String>> services = [];


  Future<void> _configurePage(BuildContext context) async {
    String companyName= _companyName.text;
    String Addy = _location.text;
    String Category = _selectedCategory.toString();
    String Email = _email.text;
    String Spec = _speciality.text;
    if (await Configure(companyName,Addy,Category,services,Email,Spec)){
      Navigator.push(
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
                );
    }
    else{
      _warningBubble();
    }

  }

  ScaffoldFeatureController _warningBubble() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(157, 126, 175, 169),
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
                  'Register failed',
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

  void _addService(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddServiceScreen(
          onAdd: (serviceData) {
            setState(() {
              services.add(serviceData);
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 230, 226),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                const Text('Configure Page', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
                const Text('Register Your Business', style: TextStyle(fontSize: 16,),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.business_center_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Business Name',
                      hintText: 'Enter Company Name',
                    ),
                    controller: _companyName,
                  ),
                ),Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter Login Email',
                    ),
                    controller: _email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Address',
                      hintText: 'Enter your Location',
                    ),
                    controller: _location,
                  ),
                ),Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.favorite),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Speciality',
                      hintText: 'Enter your Speciality',
                    ),
                    controller: _speciality,
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.arrow_drop_down_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Select Category',
                    ),
                    items: _options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 139, 201, 231),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    onTap: () => _addService(context),
                    child: const Center(
                      child: Text(
                        "Add Service",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: services.length * 125.0,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: services.length,
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
                              Container(
                                width: 80,
                                child: const Icon(Icons.food_bank_rounded),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      services[index][0],
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      "Quantity : " + services[index][1],
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "Price : " + services[index][2],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Description : " + services[index][3],
                                      style: const TextStyle(fontSize: 16),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
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
                Container(
                  height: 60,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    onTap: () => _configurePage(context),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddServiceScreen extends StatefulWidget {
  final Function(List<String>) onAdd;

  const AddServiceScreen({required this.onAdd, Key? key}) : super(key: key);

  @override
  _AddService createState() => _AddService();
}

class _AddService extends State<AddServiceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _addService() {
    List<String> serviceData = [
      _nameController.text,
      _quantityController.text,
      _priceController.text,
      _descriptionController.text,
      _discountController.text,
    ];

    widget.onAdd(serviceData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.production_quantity_limits_rounded),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                icon: Icon(Icons.numbers_rounded),
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                icon: Icon(Icons.currency_rupee_rounded),
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                icon: Icon(Icons.description_rounded),
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: _discountController,
              decoration: const InputDecoration(
                icon: Icon(Icons.discount_rounded),
                labelText: 'Discount in %',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addService,
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<int> signup(String username, String password, String email, String mode, String confpassword) async {
  // Mock signup function. Replace with actual signup logic.
  return Future.value(1);
}
