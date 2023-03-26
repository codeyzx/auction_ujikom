import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controller/authController.dart';
import 'component/authfield.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: Column(
                      children: const [
                        Text(
                          'New Here?',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Create a new account with your email and password or continue with social media",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Username
                  UsernameField(controller: usernameController),

                  const SizedBox(
                    height: 15,
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

                  const SizedBox(height: 40),

                  //Login Button
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await ref
                                .read(authControllerProvider.notifier)
                                .signUp(
                                context,
                                emailController.text,
                                passwordController.text,
                                usernameController.text);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          fixedSize: const Size(350, 40),
                          backgroundColor: (HexColor('#B1B2FF'))),
                      child: const Text("Register")),

                  const SizedBox(height: 10,),

                  const Text(
                    "or continue with",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 10,),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
