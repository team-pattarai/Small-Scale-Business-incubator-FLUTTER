import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';

import '../../components/add_service_screen.dart';

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
  ];

  List<List<String>> services = [];

  Future<void> _configurePage(BuildContext context) async {
    String companyName = _companyName.text;
    String addy = _location.text;
    String category = _selectedCategory ?? '';
    String email = _email.text;
    String spec = _speciality.text;
    
    try {
      if (await Configure(companyName, addy, category, services, email, spec)) {
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
      } else {
        _warningBubble();
      }
    } catch (e) {
      _warningBubble();
    }
  }

  void _warningBubble() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(157, 126, 175, 169),
        content: SizedBox(
          height: 50,
          child: Center(
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
        duration: Duration(seconds: 2),
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
                const Text('Configure Page', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('Register Your Business', style: TextStyle(fontSize: 16)),
                _buildTextField(_companyName, 'Business Name', 'Enter Company Name', Icons.business_center_rounded),
                _buildTextField(_email, 'Email', 'Enter Login Email', Icons.email_rounded),
                _buildTextField(_location, 'Address', 'Enter your Location', Icons.location_city_rounded),
                _buildTextField(_speciality, 'Speciality', 'Enter your Speciality', Icons.favorite),
                _buildDropdown(),
                _buildAddServiceButton(),
                _buildServicesList(),
                _buildRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          labelText: label,
          hintText: hint,
        ),
        controller: controller,
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.arrow_drop_down_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
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
    );
  }

  Widget _buildAddServiceButton() {
    return Container(
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
    );
  }

  Widget _buildServicesList() {
    return SizedBox(
      height: services.isEmpty ? 0 : services.length * 125.0,
      child: services.isEmpty
          ? const SizedBox()
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildServiceItem(index);
              },
            ),
    );
  }

  Widget _buildServiceItem(int index) {
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
  services[index][0].isNotEmpty ? services[index][0] : 'No name',
  style: const TextStyle(fontSize: 22),
),
Text(
  "Quantity : ${services[index][1].isNotEmpty ? services[index][1] : 'N/A'}",
  style: const TextStyle(fontSize: 14),
),
Text(
  "Price : ${services[index][2].isNotEmpty ? services[index][2] : 'N/A'}",
  style: const TextStyle(fontSize: 16),
),
Text(
  "Description : ${services[index][3].isNotEmpty ? services[index][3] : 'No description'}",
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
  }

  Widget _buildRegisterButton() {
    return Container(
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
    );
  }
}