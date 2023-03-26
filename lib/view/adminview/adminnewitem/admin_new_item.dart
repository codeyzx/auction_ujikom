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
            title: const Text("Tambah Barang"),
            tileColor: Colors.red,
            leading: const Icon(LineIcons.box, color: Colors.black,),
            onTap: () {

              Navigator.pushNamed(context, '/additem');

            },
          ),

          ListTile(
            title: const Text("Data Petugas"),
            tileColor: Colors.blue,
            leading: const Icon(LineIcons.users, color: Colors.black,),
            onTap: () {


            },

          ),
          const ListTile(
            title: Text("Status Lelang"),
            tileColor: Colors.yellow,
            leading: Icon(LineIcons.boxes, color: Colors.black,),

          ),
          const ListTile(
            title: Text("Laporan"),
            tileColor: Colors.green,
            leading: Icon(LineIcons.boxes, color: Colors.black,),

          )
        ],
      )
    );
  }
}
