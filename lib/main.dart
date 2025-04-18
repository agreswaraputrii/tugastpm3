import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialPage() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn ? const HomePage() : const LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialPage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Aplikasi Estetik',
          theme: ThemeData(
            primaryColor: const Color(0xFF095793),
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
            fontFamily: 'Raleway', // atau Poppins / Inter
          ),
          home: snapshot.data,
          routes: {
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
          },
        );
      },
    );
  }
}
