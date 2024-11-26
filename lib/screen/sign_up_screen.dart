import 'package:firebase3/Utility/uitils.dart';
import 'package:firebase3/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    name.clear();
    email.dispose();
    email.clear();
    password.dispose();
    password.clear();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SignUp Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
           key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: 'Enter Your Name',
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.greenAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                controller: email,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: 'Enter Your email',
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.greenAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters.";
                  }
                  return null;
                },
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
                height: 10,
              ),
              InkWell(
                onTap: ()async {
                await _auth
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  )
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                    Utils.successToast("Sign Up Successfully");
                  }).onError((error, e) {
                    Utils.successToast(error.toString());
                  });
                   print("login button");
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
                      "SignUp",
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
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
