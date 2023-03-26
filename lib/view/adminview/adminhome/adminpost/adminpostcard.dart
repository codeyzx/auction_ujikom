import 'package:auction_ujikom/view/adminview/adminnewitem/edit_item_page.dart';
import 'package:auction_ujikom/view/home/post/postexpand.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../model/items.dart';
import '../../../../model/users.dart';
import 'adminpostexpand.dart';

class AdminPostCard extends ConsumerStatefulWidget {
  final Items items;

  const AdminPostCard({Key? key, required this.items}) : super(key: key);

  @override
  ConsumerState<AdminPostCard> createState() => _AdminPostCardState();
}

class _AdminPostCardState extends ConsumerState<AdminPostCard> {
  bool isOpen = false;

  Users? users;

  // List<Comments> comments = [];

  // List<String> imagepost = [
  //   //ambil dari firebase
  //   'https://www.macworld.com/wp-content/uploads/2023/01/macbook-air-m1-hero01-100866889-orig.jpg?quality=50&strip=all&w=1024',
  //   'https://id.pinterest.com/pin/561331541068354390/'
  // ];

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  Future<void> initData() async {
    var checkUsers = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.items.uid.toString())
        .get();
    final userz = Users.fromJson(checkUsers.data()!);

    setState(() {
      users = userz;
      // comments = allComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.status == 'open') {
      isOpen = true;
    } else {
      isOpen = false;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminPostExpandView(
                      item: widget.items,
                    )));
      },
      onLongPress: () {

        Navigator.push(context,
             MaterialPageRoute(builder: (context) => EditItemPageView(item: widget.items,)));

        //print("bisa");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 5,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 100,
                    width: 100,
                    child: Image.network(
                      '${widget.items.picture}',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.items.title.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Harga Awal: " + widget.items.harga_awal.toString()),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Harga Akhir: " +
                          widget.items.harga_akhir.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      isOpen
                          ? Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.yellow,
                              ),
                              child: Text('  Open  '),
                            )
                          : Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.red,
                              ),
                              child: Text(
                                  style: TextStyle(color: Colors.white),
                                  '  Closed  '),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),

              //Button Ganti Status
              // ElevatedButton(onPressed: () {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: Text('Ganti Status Pelelangan'),
              //           content: isOpen
              //               ? Text(
              //               'Tutup status pelelangan dan merubah status menjadi closed')
              //
              //               : Text(
              //               'Buka pelelangan dan merubah status menjadi Open'),
              //
              //
              //           actions: [
              //             ElevatedButton(
              //               onPressed: () {
              //                 setState(() {
              //                   isOpen = !isOpen;
              //                 });
              //                 Navigator.of(context).pop();
              //               },
              //               child: Text('Ganti'),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop();
              //               },
              //               child: Text('Batal'),
              //               style: ElevatedButton.styleFrom(
              //                   backgroundColor: (HexColor('#B1B2FF'))),
              //             ),
              //           ],
              //         );
              //       });
              // }, child: Text('Ganti status'))
            ],
          ),
        ),
      ),
    );
  }

}
