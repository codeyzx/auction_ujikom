import 'package:auction_ujikom/model/items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

import 'component/tutuppenawaran.dart';

class AdminPostExpandView extends ConsumerStatefulWidget {
  final Items item;
  const AdminPostExpandView({Key? key, required this.item}) : super(key: key);

  @override
  ConsumerState<AdminPostExpandView> createState() => _AdminPostExpandViewState();
}

class _AdminPostExpandViewState extends ConsumerState<AdminPostExpandView> {
  @override
  Widget build(BuildContext context) {
    var hargaAwal = widget.item.harga_awal;
    var hargaTerakhir = widget.item.harga_akhir;
    List<String> imagepost = [widget.item.picture.toString()];

    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title.toString())),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      child: CarouselSlider.builder(
                        itemCount: imagepost.length,
                        options: CarouselOptions(
                          autoPlay: true,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                          child: Image.network(
                            imagepost[itemIndex],
                            fit: BoxFit.contain,
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.black.withOpacity(0.5),
                          height: 60,
                          child: Center(
                              child: Text(
                            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                .format(hargaAwal)
                                .toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                          )),
                        ),
                        Container(
                            color: Colors.yellow.withOpacity(0.75),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 60,
                            child: Center(
                                child: Text(
                              NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                  .format(hargaTerakhir)
                                  .toString(),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              softWrap: true,
                            )))
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.title.toString(),
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                  width: 300,
                                  child: Text(widget.item.about.toString(), style: const TextStyle(color: Colors.black54))),
                            ],
                          ),
                          const LikeButton()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Deskripsi detail barang'),
                          Text(widget.item.about_detail.toString(), style: const TextStyle(color: Colors.black54))
                        ],
                      )
                    ]),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // color: Colors.red,

              height: 100,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return const ModalTutupPenawaran();
                        });
                  },
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      fixedSize: Size((MediaQuery.of(context).size.width), 50),
                      backgroundColor: (HexColor('#EA5A5A'))),
                  child: const Text(
                    "Tutup Penawaran",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
