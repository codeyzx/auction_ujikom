import 'package:auction_ujikom/view/home/home.dart';
import 'package:auction_ujikom/view/newitem/newitem.dart';
import 'package:flutter/material.dart';

import '../../view/profile/profile.dart';

class ScreenIndex {
  static const List<Widget> screens = <Widget>[
    HomepageView(),
    NewItemView(),
    ProfileView(),
  ];
}
