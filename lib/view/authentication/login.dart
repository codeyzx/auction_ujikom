import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';

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
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //Illustration
                  //Image.asset('assets/img/login-illustration.png', height: 350, width: 350,),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: Column(
                      children: const [
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

                  const SizedBox(
                    height: 20,
                  ),

                  //Email
                  EmailField(
                    controller: emailController,
                  ),

                  const SizedBox(
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
                      child: const Text("Forgot your Password?",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.end),
                    ),
                  ),

                  const SizedBox(height: 30),


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
                          fixedSize: const Size(350, 40),
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
