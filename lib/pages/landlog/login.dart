import 'package:flutter/material.dart';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/landlog/signin.dart';
import 'package:flutter_application_1/pages/landlog/signup.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color[1],
      body: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100,),
          Image.asset('assets/images/Login.jpg',height: 200,),
          const SizedBox(height: 15,),
          const Text("Hello",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Color.fromARGB(255, 90, 90, 90)),),
          const SizedBox(height: 3,),
          const Text("Description os the app",style: TextStyle(fontSize: 17),),
          const SizedBox(height: 14,),
          Container(
            height: 60,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 60,right: 60),
            decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(25)),          
            child:InkWell(onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SignIn(),
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
              },child:  const Center(child:  Text("Login",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w400),))),
            
          ),
          const SizedBox(height: 20,),          
          Container(
            height: 60,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 60,right: 60),
            decoration: BoxDecoration(color: color[0],borderRadius: BorderRadius.circular(25),border: Border.all(color: Colors.blueGrey,width: 3)),   
            child:InkWell(onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SignUp(),
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
              },child:  const Center(child:  Text("Sign Up",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w400),))),        
          ),
          const SizedBox(height: 35,),
          Container(child: Column(
            children: [
              const Text("Powered By",style: TextStyle(fontSize: 16),),
              Image.asset('assets/images/Text Black.png',height: 100,width: 175,)],),),
        ],
      ),),
    );
  }
}