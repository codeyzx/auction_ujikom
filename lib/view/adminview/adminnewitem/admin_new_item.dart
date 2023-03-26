import 'package:auction_ujikom/view/adminview/adminnewitem/add_item_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AdminNewItemView extends StatefulWidget {
  const AdminNewItemView({Key? key}) : super(key: key);

  @override
  State<AdminNewItemView> createState() => _AdminNewItemStateView();
}

class _AdminNewItemStateView extends State<AdminNewItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("Tambah Barang"),
            tileColor: Colors.red,
            leading: Icon(LineIcons.box, color: Colors.black,),
            onTap: () {

              Navigator.pushNamed(context, '/additem');

            },
          ),

          ListTile(
            title: Text("Data Petugas"),
            tileColor: Colors.blue,
            leading: Icon(LineIcons.users, color: Colors.black,),
            onTap: () {


            },

          ),
          ListTile(
            title: Text("Status Lelang"),
            tileColor: Colors.yellow,
            leading: Icon(LineIcons.boxes, color: Colors.black,),

          ),
          ListTile(
            title: Text("Laporan"),
            tileColor: Colors.green,
            leading: Icon(LineIcons.boxes, color: Colors.black,),

          )
        ],
      )
    );
  }
}
