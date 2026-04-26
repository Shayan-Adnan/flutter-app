import 'package:flutter/material.dart';
import 'package:assigmment_app/controllers/auth_controller.dart';
import 'package:assigmment_app/screens/dashboard_screen.dart';
import 'package:assigmment_app/screens/login_screen.dart';
import 'package:assigmment_app/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: FutureBuilder<void>(
        future: AuthController.instance.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          switch (AuthController.instance.authStatus) {
            case AuthStatus.authenticated:
              return const DashboardScreen();
            case AuthStatus.unauthenticated:
              return const LoginScreen();
            case AuthStatus.unknown:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
          }
        },
      ),
      routes: {
        '/register': (_) => const RegisterScreen(),
        '/login': (_) => const LoginScreen(),
        '/dashboard': (_) => AuthController.instance.isLoggedIn
            ? const DashboardScreen()
            : const LoginScreen(),
      },
    );
  }
}
