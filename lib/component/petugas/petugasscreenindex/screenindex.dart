import 'package:flutter/material.dart';

import 'package:auction_ujikom/view/adminview/adminnewitem/admin_new_item.dart';

import '../../../view/adminview/adminhome/adminhome.dart';
import '../../../view/petugasview/petugasprofile.dart';

class ScreenIndex{
  static const List<Widget> screens = <Widget>[
    AdminHomeView(),
    AdminNewItemView(),
    PetugasProfileView()

  ];
}