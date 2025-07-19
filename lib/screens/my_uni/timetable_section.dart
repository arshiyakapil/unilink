import 'package:flutter/material.dart';

class Timetable extends StatelessWidget {
  final Map<String, List<String>> _timetable = const {
    'Monday': ['9 AM - CS101', '2 PM - Math202'],
    'Tuesday': ['10 AM - Physics', '1 PM - English'],
    'Wednesday': ['11 AM - Chemistry'],
    'Thursday': ['9 AM - CS101', '3 PM - Math202'],
    'Friday': ['10 AM - Physics', '2 PM - English'],
  };

  const Timetable({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _timetable.length,
      itemBuilder: (ctx, i) => ExpansionTile(
        title: Text(_timetable.keys.elementAt(i)),
        children: _timetable.values.elementAt(i).map((cls) => 
          ListTile(title: Text(cls))).toList(),
      ),
    );
  }
}
