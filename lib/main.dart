import 'package:firebase_auth_app_bloc/application/features/auth/views/login_view.dart';
import 'package:firebase_auth_app_bloc/application/features/auth/views/user_registration_view.dart';
import 'package:firebase_auth_app_bloc/application/features/home/home_view.dart';
import 'package:firebase_auth_app_bloc/application/features/splash/splash_view.dart';
import 'package:firebase_auth_app_bloc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontSize: 30),
          displayMedium: TextStyle(color: Colors.white, fontSize: 23),
          bodySmall: TextStyle(color: Colors.white, fontSize: 18),
        ),
        scaffoldBackgroundColor: Color(0xfff263147),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashWrapper(),
        '/home': (context) => const HomePageWrapper(),
        '/login': (context) => const LoginPageWrapper(),
        '/signup': (context) => const SignUpPageWrapper(),
      },
    );
  }
}
