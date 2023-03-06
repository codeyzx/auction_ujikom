import 'package:auction_ujikom/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/navbar/navbar.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {

          return MaterialApp(
            title: 'Auction',
            initialRoute: '/home',
            routes: {

              '/': (context)=> Splash(),

              // Navigating to home if user logged in
              '/home': (context) => const NavBar(),

              // Navigating to auth if user not logged in
              // '/auth': (context) => const AuthView()

            },

            theme: ThemeData(
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .apply(
                  fontFamily: 'Inter'
              ),
              colorSchemeSeed: const Color(0xffb1b2ff),
              useMaterial3: true,
            ),

          );
        }
    );
  }
}
