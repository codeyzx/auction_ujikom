import 'package:auction_ujikom/view/adminview/adminnewitem/edit_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../model/items.dart';
import 'adminpostexpand.dart';

class AdminPostCard extends ConsumerStatefulWidget {
  final Items items;

  const AdminPostCard({Key? key, required this.items}) : super(key: key);

  @override
  ConsumerState<AdminPostCard> createState() => _AdminPostCardState();
}

class _AdminPostCardState extends ConsumerState<AdminPostCard> {
  bool isOpen = false;

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditItemPageView(
                      item: widget.items,
                    )));

        //print("bisa");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 25),
        child: Card(
          shape: const RoundedRectangleBorder(
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
                    margin: const EdgeInsets.only(left: 20),
                    height: 100,
                    width: 100,
                    child: Image.network(
                      '${widget.items.picture}',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.items.title.toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Harga Awal: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.items.harga_awal)}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Harga Akhir: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.items.harga_akhir)}"),
                      const SizedBox(
                        height: 10,
                      ),
                      isOpen
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.yellow,
                              ),
                              child: const Text('  Open  '),
                            )
                          : Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.red,
                              ),
                              child: const Text(style: TextStyle(color: Colors.white), '  Closed  '),
                            ),
                      const SizedBox(
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
