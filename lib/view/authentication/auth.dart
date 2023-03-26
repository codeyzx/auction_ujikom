import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class AuthViews extends StatefulWidget {
  const AuthViews({Key? key}) : super(key: key);

  @override
  State<AuthViews> createState() => _AuthViewsState();
}

class _AuthViewsState extends State<AuthViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auction'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        shrinkWrap: false,

        children: [
          Center(
            child: Column(
              children: [
                //Illustration
                SizedBox(height: 10.h),

                //Welcome Text
                SizedBox(
                  width: 250.h,
                  child:
                  Column(
                    children: const [

                      Text("BEST Auction App ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),),

                      Text("Auction allow you to pick the best product at the best price possible")
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                //Login Button
                ElevatedButton(
                  onPressed:() => Navigator.pushNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      fixedSize: const Size(350,40),
                      backgroundColor: (HexColor('#B1B2FF'))
                  ),
                  child: const Text("Login"),
                ),
                const SizedBox(height: 5),

                //Register Button
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        fixedSize: const Size(350,40)
                    ),
                    child: const Text("Register"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
