import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> googleWithSign() async {
    try {
      final GoogleSignInAccount? googleUsers = await _googleSignIn.signIn();

      if (googleUsers == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUsers.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          print("User Display Name ${user.displayName}");
          print("User name ${user.email}");
        } else {
          print("User already ${user.displayName}");
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }

   signOut(){
     _auth.signOut();
     _googleSignIn.signOut();
   }
}
