import 'package:flutter/material.dart';

class SignUpCollegeScreen extends StatelessWidget {
  const SignUpCollegeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up Your College")),
      body: const Center(
        child: Text(
          "College Signup Page (Coming Soon)",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
