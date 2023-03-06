import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class NewItemView extends ConsumerStatefulWidget {
  const NewItemView({Key? key}) : super(key: key);

  @override
  ConsumerState<NewItemView> createState() => _NewItemViewState();
}

class _NewItemViewState extends ConsumerState<NewItemView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning, color: Colors.red, size: 60),
          Text(
              style: TextStyle(fontSize: 18),
              "Hanya Admin dan Petugas yang dapat menambahkan Barang",
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
