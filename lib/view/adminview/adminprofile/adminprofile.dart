import 'package:flutter/material.dart';

class AdminProfileView extends StatefulWidget {
  const AdminProfileView({Key? key}) : super(key: key);

  @override
  State<AdminProfileView> createState() => _AdminProfileStateView();
}

class _AdminProfileStateView extends State<AdminProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('AdminProfile'),
    );
  }
}
