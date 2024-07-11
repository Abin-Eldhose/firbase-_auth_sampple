import 'package:firebase_auth_app_bloc/application/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:firebase_auth_app_bloc/application/features/auth/model/user_model.dart';
import 'package:firebase_auth_app_bloc/application/features/auth/views/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPageWrapper extends StatelessWidget {
  const SignUpPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _emailContoller.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBlocBloc>(context);
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(builder: (context, state) {
      if (state is Authenticated) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      }
      return Scaffold(
          appBar: AppBar(),
          body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: double.infinity,
              width: double.infinity,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up with email",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            controller: _nameController,
                            hintText: "Enter your Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            controller: _emailContoller,
                            hintText: "Enter your email"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            controller: _phoneController,
                            hintText: "Enter Phone Number"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "Enter New Password",
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            UserModel user = UserModel(
                              name: _nameController.text,
                              password: _passwordController.text,
                              email: _emailContoller.text,
                              phone: _phoneController.text,
                            );
                            authBloc.add(SignUpEvent(user: user));
                          },
                          child: Container(
                            width: size.width * 0.6,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
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
                              "Already have an account ?.. ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text(
                                  "Login",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )));
    });
  }
}
