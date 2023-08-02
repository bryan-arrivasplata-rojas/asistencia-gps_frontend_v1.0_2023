// ignore_for_file: unused_local_variable, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator{
  static Future<User?> iniciarSesion({required BuildContext context}) async {
    FirebaseAuth authenticator = FirebaseAuth.instance;
    User? user;
    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    final GoogleSignInAccount? objGoogleSignInAccount = await objGoogleSignIn.signIn().catchError((onError) => print(onError));;
    if(objGoogleSignInAccount != null){
      GoogleSignInAuthentication objGoogleSignInAuthentication = await  objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: objGoogleSignInAuthentication.accessToken,
        idToken: objGoogleSignInAuthentication.idToken
      );
      try{
        UserCredential userCredential = await authenticator.signInWithCredential(credential);
        user = userCredential.user;
        return user;
      }on FirebaseAuthException catch(e){
        return user;
      }
    }else{
      return null;
    }
  }
  static Future<void> signOutGoogle()async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}