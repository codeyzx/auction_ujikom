import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/items.dart';
import '../model/users.dart';



class ItemController extends StateNotifier<List<Items>> {
  ItemController() : super([]);

  final db = FirebaseFirestore.instance.collection('items');
  final doc = FirebaseFirestore.instance.collection('items').doc();

  Future<void> addItem({required String uid, required String title}) async {
    await doc.set({
      'itemid': doc.id,
      'uid': uid,
      'title': '',
      'about': '',
      'about_detail': '',
      'picture': '',
      'createdAt':DateTime.now().toString(),
      'harga_awal': 0,
      'harga_akhir' : 0,
      // 'createdAt': Timestamp.fromDate(DateTime.now()),
    });
    await getItem();
  }

  Future<void> getItem() async {
    final docRef = db.withConverter(
      fromFirestore: (snapshot, _) => Items.fromJson(snapshot.data()!),
      toFirestore: (Items items, _) => items.toJson(),
    ).orderBy("createdAt".toString(), descending: true);
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
