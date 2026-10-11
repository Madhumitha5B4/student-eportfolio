import 'package:flutter/material.dart';

import 'login_page.dart';

void main() => runApp(const EPortfolioApp());

class EPortfolioApp extends StatelessWidget {
  const EPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student E-Portfolio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3F51B5),
      ),
      home: const LoginPage(),
    );
  }
}
