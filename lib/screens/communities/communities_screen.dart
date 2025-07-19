import 'package:flutter/material.dart';

class CommunitiesScreen extends StatelessWidget {
  static const List<String> clubs = ['Tech Club', 'Sports', 'Debate', 'Arts'];

  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: clubs.map((club) => Card(
        child: Center(child: Text(club)),
      )).toList(),
    );
  }
}
