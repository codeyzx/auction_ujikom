import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../petugas/petugasscreenindex/screenindex.dart';





class PetugasNavBar extends StatefulWidget {
  const PetugasNavBar({Key? key}) : super(key: key);

  @override
  State<PetugasNavBar> createState() => _PetugasNavBarState();
}

class _PetugasNavBarState extends State<PetugasNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ SystemChannels.platform.invokeMethod('SystemNavigator.pop'); return true; },
      child: Scaffold(
          body: PageView(
            scrollDirection: Axis.vertical,
            children: [
              ScreenIndex.screens.elementAt(_selectedIndex),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 6,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.plus,
                      //text: 'Search',
                    ),
                    // GButton(
                    //   icon: LineIcons.bell,
                    //   //text: 'Notification',
                    // ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),


          )
      ),
    );
  }
}
