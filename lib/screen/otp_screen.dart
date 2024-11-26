import 'package:firebase3/screen/homescreen.dart';
import 'package:flutter/material.dart';

class OTpScreen extends StatefulWidget {
  const OTpScreen({super.key});

  @override
  State<OTpScreen> createState() => _OTpScreenState();
}

class _OTpScreenState extends State<OTpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP Screen",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "OTP",
                  label: Text("OTP 6 digit"),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Homescreen()));
              },

              child:Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
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
