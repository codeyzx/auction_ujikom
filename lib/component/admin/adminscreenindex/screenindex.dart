
import 'package:flutter/material.dart';

import 'package:auction_ujikom/view/adminview/adminnewitem/admin_new_item.dart';
import 'package:auction_ujikom/view/adminview/adminprofile/adminprofile.dart';

import '../../../view/adminview/adminhome/adminhome.dart';

class ScreenIndex{
  static const List<Widget> screens = <Widget>[
    AdminHomeView(),
    AdminNewItemView(),
    AdminProfileView()

  ];
}