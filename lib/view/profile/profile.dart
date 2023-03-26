import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import '../../controller/authController.dart';
import '../authentication/auth.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {

  @override
  Widget build(BuildContext context) {

    final users = ref.watch(authControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: const [],
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.only(
              left: 15.h, right: 15.h, top: 10.h, bottom: 200.h),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
            BoxShadow(

                blurRadius: 2,
                color: Colors.black38),
          ]),
          child: Column(

            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  const CircleAvatar(),

                  const SizedBox(width: 20,),
                  //username and email
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((users.name).toString() ),
                      Text((users.email).toString() ),
                      Text((users.role).toString() )


                    ],
                    
                  ),

                ],
              ),

              const SizedBox(height: 10,),

              ListTile(

                title: const Text('History Lelang'),
                leading: const Icon(LineIcons.history, color: Colors.black,),
                onTap: () {

                },
              ),

              const ListTile(
                title: Text('Edit Profile'),
                leading: Icon(LineIcons.user, color: Colors.black,),
              ),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300.h, 40)
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Log Out'),
                          content: const Text(
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
                              child: const Text('Logout'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: (HexColor('#B1B2FF'))),
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      });
                },
                child: const Text('Log Out'),
              ),

              const SizedBox(height: 10,)


            ],
          ),
        ),

        //Center(child: Text('Ini Profile')),
        );
  }
}
