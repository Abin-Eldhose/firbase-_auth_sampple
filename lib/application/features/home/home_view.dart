import 'package:firebase_auth_app_bloc/application/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//create the bloc wrapper class
class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  //add logout event
                  final authBloc = BlocProvider.of<AuthBlocBloc>(context);
                  authBloc.add(LogOutEvent());
                  //logout and navigate to login page
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: const Column(
            children: [],
          ),
        ));
  }
}
