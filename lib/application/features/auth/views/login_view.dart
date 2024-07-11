import 'package:firebase_auth_app_bloc/application/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:firebase_auth_app_bloc/application/features/auth/views/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailContoller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authbloc = BlocProvider.of<AuthBlocBloc>(context);
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(builder: (context, state) {
      if (state is Authenticated) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      }

      return Scaffold(
          body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login With Email",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
                controller: _emailContoller, hintText: "Enter email"),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: _passwordController,
              hintText: "Enter Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            InkResponse(
              onTap: () {
                authbloc.add(LoginEvent(
                    email: _emailContoller.text.trim(),
                    password: _passwordController.text.trim()));
              },
              child: Container(
                width: size.width * 0.6,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Log In",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "First time here ?.. ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.bodySmall,
                    ))
              ],
            )
          ],
        ),
      ));
    });
  }
}
