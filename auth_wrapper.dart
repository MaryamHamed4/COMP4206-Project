import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:templatemidterm/pages/home_page.dart';
import 'package:templatemidterm/pages/login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Waiting for connection to Firebase
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Check if user is logged in
        if (snapshot.hasData && snapshot.data != null) {
          return const MyHomePage(title: 'Home Page');
        } else {
          return const LoginRegisterPage();
        }
      },
    );
  }
}

