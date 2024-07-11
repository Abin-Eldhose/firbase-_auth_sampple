import 'package:firebase_auth_app_bloc/application/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//make a wrapper class
class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc()..add(CheckLoginStatusEvent()),
      child: SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        // Check the current state and perform actions accordingly
        if (state is Authenticated) {
          // Navigate to the home screen
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is UnAuthenticated) {
          // Navigate to the login screen
          Navigator.of(context).pushReplacementNamed('/login');
        } else if (state is AuthenticationError) {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/splash.png',
                  height: size.height * 0.4,
                  width: size.width * 0.4,
                ),
              ),
              Text(
                "Auth Using Firebase & Bloc",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
