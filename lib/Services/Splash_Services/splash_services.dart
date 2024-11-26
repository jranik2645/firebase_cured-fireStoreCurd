
import 'package:firebase3/screen/homescreen.dart';
import 'package:firebase3/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices{

   void isLogin(BuildContext context){
      final auth=FirebaseAuth.instance;
      final user=auth.currentUser;
      
      if(user !=null){

       Future.delayed(Duration(seconds: 3), ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const Homescreen()), (route)=>false));



      }else{
        Future.delayed(Duration(seconds: 3),()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()), (route)=>false));
      }
   }

}