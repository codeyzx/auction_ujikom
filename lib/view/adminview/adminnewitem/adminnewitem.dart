import 'package:flutter/material.dart';

class AdminNewItemView extends StatefulWidget {
  const AdminNewItemView({Key? key}) : super(key: key);

  @override
  State<AdminNewItemView> createState() => _AdminNewItemStateView();
}

class _AdminNewItemStateView extends State<AdminNewItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Admin New Item'),
    );
  }
}
