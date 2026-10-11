import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'data.dart';
import 'ui_common.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _roll = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _hidePass = true;

  @override
  void dispose() {
    _roll.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _login() {
    final roll = _roll.text.trim();
    final pass = _pass.text.trim();
    if (roll.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Roll No. and Password')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DashboardPage(rollNo: roll)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Card(
                  elevation: 8,
                  shape: kCardShape,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Student photo: round, radius 60. Falls back to initials.
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: scheme.primaryContainer,
                          child: ClipOval(
                            child: Image.asset(
                              profilePhoto,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Text(
                                initials,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: scheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        // App logo with the title underneath
                        Image.asset(
                          appLogo,
                          height: 48,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.school, size: 44, color: scheme.primary),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'My Portfolio',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fullName,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 15),
                        ),
                        const SizedBox(height: 26),
                        // Roll No.
                        TextField(
                          controller: _roll,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Roll No.',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password with show/hide eye button
                        TextField(
                          controller: _pass,
                          obscureText: _hidePass,
                          onSubmitted: (_) => _login(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_hidePass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () =>
                                  setState(() => _hidePass = !_hidePass),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton(
                            onPressed: _login,
                            child: const Text('Login',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
