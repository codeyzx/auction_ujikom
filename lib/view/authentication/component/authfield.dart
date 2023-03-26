import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

//Custom Widget Username
class UsernameField extends StatefulWidget {
  final TextEditingController controller;

  const UsernameField({Key? key,  required this.controller}) : super(key: key);

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.name,
        validator: (value) {
          if(value!.isEmpty ){return 'Please fill your username';}
          else if (value.length > 20) {return 'Username is too long';}
          return null;
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(LineIcons.userCircle),
          labelText: 'Username',
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),



        )
    );
  }
}


//Custom Widget Email Field
class EmailField extends StatefulWidget {
  final TextEditingController controller;

  const EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return //Email
      TextFormField(

        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email cannot be empty";
          }
          if (!RegExp(
              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter a valid email");
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(LineIcons.envelope),
          labelText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
        ),
      );
  }
}

// Custom Widget Password Field
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passenable = true; //track password value

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {


        if(value!.isEmpty) {return 'Your password is incorrect';}
        else if (value.length < 8) {return 'Password must be atleast 8 characters long';}
        return null;
      },

      keyboardType: TextInputType.visiblePassword,
      obscureText: passenable,
      decoration: InputDecoration(
        prefixIcon: const Icon(LineIcons.userLock),
        labelText: 'Password',
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (passenable) {
                  passenable = false;
                } else {
                  passenable = true;
                }
              });
            },
            icon: Icon(
                passenable == true
                    ? LineIcons.eye
                    : LineIcons.eyeSlash
            )
        ),
      ),
    );
  }
}

