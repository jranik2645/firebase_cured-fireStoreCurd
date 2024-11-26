import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices2 {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   final GoogleSignIn googleSignIn =GoogleSignIn();

   Future<User?> googleWithSign()async{
     try{
         final GoogleSignInAccount? googleSignInAccount=await googleSignIn.signIn();

         if(googleSignInAccount == null){
           return null;
         }
          final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

         final AuthCredential authCredential=GoogleAuthProvider.credential(
           accessToken: googleSignInAuthentication.accessToken,
           idToken: googleSignInAuthentication.idToken
         );

            final UserCredential credential=await _auth.signInWithCredential(authCredential);

            final User? user=credential.user;

             if(user!=null){
                if(credential.additionalUserInfo!.isNewUser){

                  print("User Display Name ${user.displayName}");
                }
                 else{
                   print("User already ${user.displayName}");
                }
             }

     }catch(e){
       print(e.toString());
     }
     return null;
   }

     SignOut(){
          _auth.signOut();
          googleSignIn.signOut();
     }
}


