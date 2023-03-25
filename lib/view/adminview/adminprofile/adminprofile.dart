import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import '../../../controller/authController.dart';
import '../../authentication/auth.dart';


class AdminProfileView extends ConsumerStatefulWidget {
  const AdminProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminProfileView> createState() => _AdminProfileStateView();
}

class _AdminProfileStateView extends ConsumerState<AdminProfileView> {

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: 15.h, right: 15.h, top: 10.h, bottom: 200.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(

                  blurRadius: 2,
                  color: Colors.black38),
            ]),
        child: Column(

          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                CircleAvatar(),

                SizedBox(width: 20,),
                //username and email
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text((users.name).toString()),
                    Text((users.email).toString()),
                    Text((users.role).toString())


                  ],

                ),

              ],
            ),

            SizedBox(height: 10,),

            ListTile(

              title: Text('History Lelang'),
              leading: Icon(LineIcons.history, color: Colors.black,),
              onTap: () {

              },
            ),

            ListTile(
              title: Text('Edit Profile'),
              leading: Icon(LineIcons.user, color: Colors.black,),
            ),

            ListTile(
              title: Text('Ini Profile Admin'),
              leading: Icon(LineIcons.user, color: Colors.black,),
            ),

            Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(300.h, 40)
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Log Out'),
                        content: Text(
                            'You will be logged out from your account, your saved content may dissapear.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .googleSignOut();

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AuthViews(),
                                  ),
                                      (route) => false);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const AuthViews(),
                              //     )
                              //     );
                            },
                            child: Text('Logout'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: (HexColor('#B1B2FF'))),
                          ),
                        ],
                      );
                    });
              },
              child: Text('Log Out'),
            ),

            SizedBox(height: 10,)


          ],
        ),
      ),

      //Center(child: Text('Ini Profile')),
    );
  }
}