import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _uniIdController = TextEditingController();

  @override
  void dispose() {
    _uniIdController.dispose(); // cleanup
    super.dispose();
  }

  Future<void> _login() async {
    final uniId = _uniIdController.text.trim();

    if (uniId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your University ID')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:3000/api/login'),
      body: {'uniId': uniId},
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid University ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login with Uni ID')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _uniIdController,
              decoration: const InputDecoration(
                labelText: 'University ID',
                hintText: 'e.g., 2023CS101',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

