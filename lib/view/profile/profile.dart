import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
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
                      Text("Username"),
                      Text("username@gmail.com"),


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
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300.h, 40)
                ),

                onPressed: () {  },
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
