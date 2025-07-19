import 'package:flutter/material.dart';

import 'timetable_section.dart';

class MyUniScreen extends StatelessWidget {
  const MyUniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map)),
              Tab(icon: Icon(Icons.calendar_today)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                
                Timetable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
