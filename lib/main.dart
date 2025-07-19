import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Screens ────────────────────────────────────────────────────────────────
import 'screens/carousel_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/select_campus_screen.dart';
import 'screens/auth/scan_or_enter_id_screen.dart';
import 'screens/auth/signup_college_screen.dart';
import 'screens/home_tabs.dart';
import 'screens/auth/id_scan_screen.dart';

void main() {
  runApp(const UniLinkApp());
}

class UniLinkApp extends StatelessWidget {
  const UniLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A1B9A)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IntroCarouselScreen(), // Not const because controller is non-const
        '/login': (context) => const LoginScreen(),
        '/select-campus': (context) => const SelectCampusScreen(),
        '/scan-or-enter': (context) => const ScanOrEnterIdScreen(),
        '/signup-college': (context) => const SignUpCollegeScreen(),
        '/home': (context) => const HomeScreen(),
        '/scan-id': (ctx) => const ScanIdScreen(),

      },
    );
  }
}
