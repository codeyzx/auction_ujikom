import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../controller/authController.dart';
import '../../model/users.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  bool isSplash = false;

  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final users = await ref.read(authControllerProvider.notifier).checkUsers();
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isSplash = true;
      });

      if (users != null) {
        if (users?.role == 'user'){
          Navigator.pushReplacementNamed(context, '/userhome');
        } else if (users?.role == 'admin'){
          Navigator.pushReplacementNamed(context, '/adminhome');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/auth');
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("ini splash")),
    );
  }
}
