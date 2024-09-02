import 'package:chatapp/core/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Button(
          text: "Test",
          onPressed0: () {
            print("--- ${FirebaseAuth.instance.currentUser!.email}");
            print("--- ${FirebaseAuth.instance.currentUser!.displayName}");
            print("--- ${FirebaseAuth.instance.currentUser!.photoURL}");
            //  print("--- ${FirebaseAuth.instance.currentUser!}");
          },
        ),
      ),
    );
  }
}
