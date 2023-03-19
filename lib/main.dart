import 'package:auction_ujikom/view/authentication/auth.dart';
import 'package:auction_ujikom/view/authentication/login.dart';
import 'package:auction_ujikom/view/authentication/register.dart';
import 'package:auction_ujikom/view/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/admin/adminnavbar/navbar.dart';
import 'component/navbar/navbar.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
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
            initialRoute: '/',
            routes: {

              '/': (context)=> Splash(),

              // Navigating to home if user logged in
              '/userhome': (context) => const UserNavBar(),

              // Navigating to admin home if home logged in
              '/adminhome': (context) => const AdminNavBar(),


              '/auth':(context) => const AuthViews(),

              //Navigating to Login Page
              '/login': (context) => const LoginView(),
              //Navigating to Register Page
              '/register':(context) => const RegisterView(),

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
