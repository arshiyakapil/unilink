import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const CommunitiesScreen(),
    const MyUniScreen(),
    const RequestsScreen(),
    const ProfileScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        title: const Text('UniLink', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // TODO: Open notification drawer or page
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () {
              // TODO: Open chat screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        print('Navigating to LoginScreen...');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (route) => false,
                        );
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF6A1B9A),
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // TODO: Open post creator
              },
            )
          : null,
    );
  }
}

// Placeholder screens for demonstration
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(isMobile ? 12.0 : 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, size: 24, color: Color(0xFF111418)),
                const Text(
                  'UniLink',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111418),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, size: 24, color: Color(0xFF111418)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Stories
          SizedBox(
            height: isMobile ? 100 : 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: isMobile ? 8 : 16),
              children: [
                _buildStoryItem(Colors.blue, '+ Your Story'),
                _buildStoryItem(Colors.red, 'Ethan'),
                _buildStoryItem(Colors.green, 'Olivia'),
                _buildStoryItem(Colors.orange, 'Noah'),
                _buildStoryItem(Colors.purple, 'Ava'),
                _buildStoryItem(Colors.teal, 'Liam'),
                _buildStoryItem(Colors.pink, 'Sophia'),
              ],
            ),
          ),
          // First Post
          _buildPost(
            'Sarah Chen',
            'CS \'25',
            'Just finished a great study session at the library! Anyone else prepping for finals? #studymode #finalsweek',
            Colors.blue,
            [Colors.red, Colors.green, Colors.orange],
            23, 5, 2,
            isMobile,
          ),
          // Second Post
          _buildPost(
            'David Lee',
            'CS \'24',
            'Excited for the upcoming hackathon! Looking for teammates with experience in web development. DM me if interested! #hackathon #coding',
            Colors.purple,
            [Colors.teal, Colors.pink],
            18, 3, 1,
            isMobile,
          ),
          SizedBox(height: isMobile ? 80 : 120), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildStoryItem(Color color, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF111418),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPost(String name, String year, String caption, Color mainColor, List<Color> additionalColors, int likes, int comments, int shares, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main image
          Container(
            height: isMobile ? 200 : 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: mainColor,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          // Name and caption
          Text(
            name,
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111418),
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            caption,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Color(0xFF60758A),
            ),
          ),
          SizedBox(height: isMobile ? 4 : 8),
          Text(
            year,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Color(0xFF60758A),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          // Additional images grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: additionalColors.map((color) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          // Like, comment, share buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(Icons.favorite_border, likes, isMobile),
              _buildActionButton(Icons.mode_comment_outlined, comments, isMobile),
              _buildActionButton(Icons.send, shares, isMobile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, int count, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon, size: isMobile ? 24 : 32, color: const Color(0xFF60758A)),
          SizedBox(width: isMobile ? 4 : 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: isMobile ? 13 : 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF60758A),
            ),
          ),
        ],
      ),
    );
  }
}
class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Communities', style: Theme.of(context).textTheme.headlineMedium));
  }
}
class MyUniScreen extends StatelessWidget {
  const MyUniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('My Uni', style: Theme.of(context).textTheme.headlineMedium));
  }
}
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Requests', style: Theme.of(context).textTheme.headlineMedium));
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile', style: Theme.of(context).textTheme.headlineMedium));
  }
}
// Custom Bottom Navigation Bar
class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, 'Feed', 0, context),
          _navItem(Icons.group, 'Communities', 1, context),
          _navItem(Icons.school, 'My Uni', 2, context),
          _navItem(Icons.help_outline, 'Requests', 3, context),
          _navItem(Icons.person, 'Profile', 4, context),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index, BuildContext context) {
    final isSelected = selectedIndex == index;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6A1B9A) : Colors.grey,
            size: isMobile ? 24 : 32,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6A1B9A) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: isMobile ? 12 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
