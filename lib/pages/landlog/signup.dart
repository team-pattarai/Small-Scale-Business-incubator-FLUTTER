import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/login.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confpassword = TextEditingController();
  String? _selectedOption;
  final List<String> _options = ['Seller', 'Consumer'];
  bool _obscureText = true;

  Future<void> _Signup(BuildContext context) async {
    String username = _email.text;
    String password = _password.text;
    String email = _email.text;
    String confpassword = _confpassword.text;
    String mode = _selectedOption.toString();

    if (await Signupup( username,  password, email, mode, confpassword)) {

      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const loginPage(),
      ),
    );
    } else {
      _warningBubble();
    }
  }

  Future<dynamic> _navigateToMainPage() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreenBody(),
      ),
    );
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
                  'Login failed',
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
    return Scaffold(
      backgroundColor: color[1],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                const Text('SignUp', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
                const Text('Create your account', style: TextStyle(fontSize: 16,),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com',
                    ),
                    controller: _email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                    controller: _username,
                  ),
                ),
                 Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: _selectedOption,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.arrow_drop_down_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: 'Select Designation',
                ),
                items: _options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
              ),
            ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                    controller: _password,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                    controller: _confpassword,
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
                    onTap: () => _Signup(context),
                    child: const Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to login page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const loginPage()),
                            );
                          },
                      ),
                    ],
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
