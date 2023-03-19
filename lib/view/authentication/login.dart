import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import '../../controller/authController.dart';
import 'component/authfield.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40),
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //Illustration
                  //Image.asset('assets/img/login-illustration.png', height: 350, width: 350,),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Sign in with your email and password or continue with social media",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //Email
                  EmailField(
                    controller: emailController,
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  //Password
                  PasswordField(
                    controller: passwordController,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/resetpassword');
                      },
                      child: Text("Forgot your Password?",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.end),
                    ),
                  ),

                  SizedBox(height: 30),


                  //Login Button
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await ref
                                .read(authControllerProvider.notifier)
                                .logIn(context,
                                emailController.text.trim(),
                                passwordController.text.trim());
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          fixedSize: Size(350, 40),
                          backgroundColor: (HexColor('#B1B2FF'))),
                      child: const Text("Login")),

                  const Text(
                    "or continue with",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
