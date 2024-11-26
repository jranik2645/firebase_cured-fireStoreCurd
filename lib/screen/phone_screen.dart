import 'package:flutter/material.dart';

import 'otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});
  @override
  State<PhoneNumberScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phone Number",
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
                       hintText: "Phone Number",
                    label: Text("Phone Number"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const OTpScreen()));
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
