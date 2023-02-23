import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> registard(String email, String password,BuildContext context) async{

    try{
      UserCredential userCredential =  await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;

    }on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));

    }catch(e){

    }

  }

  Future<User?> login(String email, String password,BuildContext context) async{
    //thsi is commit

    try{
      UserCredential userCredential =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;

    }on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));

    }catch(e){

    }

  }

  Future signOut()async{
    await firebaseAuth.signOut();
  }
}