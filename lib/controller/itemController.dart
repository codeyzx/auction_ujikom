import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

      // 'createdAt': Timestamp.fromDate(DateTime.now()),
    });

    // final auth = FirebaseAuth.instance;
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Menambah data barang',
    //   'uid': uid,
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });

    await getItem();
  }

  Future<void> updateItem(
      {required BuildContext context,
      required String uid,
      required String title,
      required String about,
      required String about_detail,
      required String picture,
      required dynamic harga_awal}) async {
    await doc.update({
      'uid': uid,
      'title': title,
      'about': about,
      'about_detail': about_detail,
      'picture': picture,
      'harga_awal': harga_awal,
    });

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('#B1B2FF'),
              ),
            ));

    // final auth = FirebaseAuth.instance;
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Mengubah data barang',
    //   'uid': uid,
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });

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
    var checkUsers =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final users = Users.fromJson(checkUsers.data()!);
    return users;
  }
}

final itemControllerProvider =
    StateNotifierProvider<ItemController, List<Items>>(
  (ref) => ItemController(),
);
