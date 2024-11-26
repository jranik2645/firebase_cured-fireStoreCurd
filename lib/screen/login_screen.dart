import 'package:firebase3/Auth/Firebase_services/Authetntication_services.dart';
import 'package:firebase3/screen/homescreen.dart';
import 'package:firebase3/screen/phone_screen.dart';
import 'package:firebase3/screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utility/uitils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    email.clear();
    password.dispose();
    password.clear();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
   AuthServices services =AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Login_Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDnfVDrdvRtjYAzgWtQ_Ak1WwnmOQba5TT_g&s")),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: 'Enter Your Email',
                    prefixIcon: Icon(Icons.email_rounded),
                    prefixIconColor: Colors.greenAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: 'Enter Your Password',
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.greenAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  await _auth
                      .signInWithEmailAndPassword(
                          email: email.text, password: password.text)
                      .then((value) {
                    Utils.successToast(" Successfully Login");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  Homescreen()));
                  }).onError((error, e) {
                    Utils.successToast(error.toString());
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Homescreen()));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "OR",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(
                height: 30,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                     onTap: (){
                            services.googleWithSign().then((value){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>const Homescreen()));
                                Utils.successToast("Success Google Login");
                            }).onError((error,e){
                              Utils.failToast(error.toString());
                            });

                     },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/icon/search.png"),
                    ),
                  ),



                  const SizedBox(
                    width: 20,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneNumberScreen()));
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/icon/phone-call.png"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
