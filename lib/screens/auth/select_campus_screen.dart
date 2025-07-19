import 'package:flutter/material.dart';

class SelectCampusScreen extends StatelessWidget {
  const SelectCampusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final campuses = ['SRM Sonepat', 'Other College (Coming Soon)'];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Campus')),
      body: ListView.builder(
        itemCount: campuses.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(campuses[i]),
          onTap: () {
            if (campuses[i] == 'SRM Sonepat') {
              Navigator.pushNamed(context, '/scan-id'); // go to scanner screen
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Only SRM Sonepat supported now')),
              );
            }
          },
        ),
      ),
    );
  }
}
