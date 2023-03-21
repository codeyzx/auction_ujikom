import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AddItemPageView extends StatefulWidget {
  const AddItemPageView({Key? key}) : super(key: key);

  @override
  State<AddItemPageView> createState() => _AddItemPageViewState();
}

class _AddItemPageViewState extends State<AddItemPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( actions: [

      ]),

      body: ListView(
        children: [
          Column(
            children: [
              Text('Tambah Item Baru'),
              Text('Upload gambar serta informasi mengenai barang disini')
            ],
          ),

          Column(
            children: [
              Center(child: IconButton(onPressed: () {

              }, icon: Icon(LineIcons.camera),)),
              Text('Upload Image')
            ],

          )
        ],
      ),
    );
  }
}
