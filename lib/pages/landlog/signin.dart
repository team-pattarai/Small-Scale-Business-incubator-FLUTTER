import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/signup.dart';
import 'package:flutter_application_1/pages/landlog/authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (await loginin(username, password)) {
      _navigateToMainPage();
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
                const SizedBox(height: 170),
                Image.asset('assets/images/Login.jpg', height: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Email Id',
                      hintText: 'Enter valid email id as abc@gmail.com',
                    ),
                    controller: _usernameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
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
                    controller: _passwordController,
                  ),
                ),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    onTap: () => _login(context),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUp()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35,),
                
                

              ],
            ),
          ),
        ),
      ),
    );
  }
}
