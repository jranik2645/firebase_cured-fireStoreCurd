import 'dart:async';

import 'package:firebase3/Services/Splash_Services/splash_services.dart';
import 'package:firebase3/screen/login_screen.dart';
import 'package:firebase3/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices  splashServices= SplashServices ();
  @override
  void initState() {
    splashServices.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff061822),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/icon/dream.jpg",
            )),
            SizedBox(
              height: 120,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
                child: Container(
                  width: double.infinity,
                  height: 50,
                   decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                   ),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Skip",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                         SizedBox(width: 10,),
                      Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
