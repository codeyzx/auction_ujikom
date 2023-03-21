import 'package:auction_ujikom/view/home/post/postexpand.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';

import 'adminpostexpand.dart';

class AdminPostCard extends ConsumerStatefulWidget {
  const AdminPostCard({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminPostCard> createState() => _AdminPostCardState();
}

class _AdminPostCardState extends ConsumerState<AdminPostCard> {
  bool isOpen = true;

  List<String> imagepost = [
    //ambil dari firebase
    'https://www.macworld.com/wp-content/uploads/2023/01/macbook-air-m1-hero01-100866889-orig.jpg?quality=50&strip=all&w=1024',
    'https://id.pinterest.com/pin/561331541068354390/'
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminPostExpandView()));
      },
      onLongPress: () {
        print("bisa");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("Kucing Kampung Nakal",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Harga Awal: 7.000.000"),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Harga Akhir: 8.000.000"),
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
           ElevatedButton(onPressed: () {

             showDialog(
                 context: context,
                 builder: (context) {
                   return AlertDialog(
                     title: Text('Ganti Status Pelelangan'),
                     content: isOpen
                         ? Text('Tutup status pelelangan dan merubah status menjadi closed')

                         : Text(
                         'Buka pelelangan dan merubah status menjadi Open'),


                     actions: [
                       ElevatedButton(
                         onPressed: () {

                           setState(() {
                             isOpen=!isOpen;
                           });
                           Navigator.of(context).pop();


                         },
                         child: Text('Ganti'),
                       ),
                       ElevatedButton(
                         onPressed: () {
                           Navigator.of(context).pop();
                         },
                         child: Text('Batal'),
                         style: ElevatedButton.styleFrom(
                             backgroundColor: (HexColor('#B1B2FF'))),
                       ),
                     ],
                   );
                 });


           }, child: Text('Ganti status'))
            ],
          ),
        ),
      ),
    );
  }
}
