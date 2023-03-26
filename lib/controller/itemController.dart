import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/items.dart';
import '../model/users.dart';

class ItemController extends StateNotifier<List<Items>> {
  ItemController() : super([]);

  final db = FirebaseFirestore.instance.collection('items');
  final doc = FirebaseFirestore.instance.collection('items').doc();

  Future<void> addItem(
      {required String uid,
      required String title,
      required String about,
      required String about_detail,
      required String picture,
      required dynamic harga_awal}) async {
    await doc.set({
      'itemid': doc.id,
      'uid': uid,
      'title': title,
      'about': about,
      'about_detail': about_detail,
      'picture': picture,
      'createdAt': DateTime.now().toString(),
      'harga_awal': harga_awal,
      'harga_akhir': harga_awal,
      'status': 'open'
    });

    await getItem();
  }

  Future<void> updateItem(
      {required BuildContext context,
      required String uid,
      required String title,
      required String about,
      required String aboutDetail,
      required String picture,
      required dynamic hargaAwal}) async {
    await db.doc(uid).update({
      'uid': uid,
      'title': title,
      'about': about,
      'about_detail': aboutDetail,
      'picture': picture,
      'harga_awal': hargaAwal,
    });

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('#B1B2FF'),
              ),
            ));

    await getItem();
  }

  Future<void> getItem() async {
    final docRef = db
        .withConverter(
          fromFirestore: (snapshot, _) => Items.fromJson(snapshot.data()!),
          toFirestore: (Items items, _) => items.toJson(),
        )
        .orderBy("createdAt".toString(), descending: true);
    final data = await docRef.get();
    state = data.docs.map((e) => e.data()).toList();
  }

  Future<Users> getUsers({required String uid}) async {
    var checkUsers = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final users = Users.fromJson(checkUsers.data()!);
    return users;
  }
}

final itemControllerProvider = StateNotifierProvider<ItemController, List<Items>>(
  (ref) => ItemController(),
);
