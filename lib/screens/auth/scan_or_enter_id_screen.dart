import 'package:flutter/material.dart';

class ScanOrEnterIdScreen extends StatelessWidget {
  const ScanOrEnterIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Enter or Scan ID")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Enter College ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement camera-based ID scanning
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Scan College ID"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
