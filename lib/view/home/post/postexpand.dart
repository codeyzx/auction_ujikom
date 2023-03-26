import 'package:auction_ujikom/view/home/post/component/tawar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';

class PostExpandView extends ConsumerStatefulWidget {
  const PostExpandView({Key? key}) : super(key: key);

  @override
  ConsumerState<PostExpandView> createState() => _PostExpandViewState();
}

class _PostExpandViewState extends ConsumerState<PostExpandView> {
  List<String> imagepost = [
    //ambil dari firebase
    'https://www.macworld.com/wp-content/uploads/2023/01/macbook-air-m1-hero01-100866889-orig.jpg?quality=50&strip=all&w=1024',
    'https://id.pinterest.com/pin/561331541068354390/'
  ];

  @override
  Widget build(BuildContext context) {
    var hargaAwal = 15000000;
    var hargaTerakhir = 20000000;

    bool isOpen = false;

    return Scaffold(
      appBar: AppBar(title: const Text('Ambil dari Judul document firebase')),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: CarouselSlider.builder(
                        itemCount: imagepost.length,
                        options: CarouselOptions(
                          autoPlay: true,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Container(
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
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  hargaAwal.toString())),
                        ),
                        Container(
                            color: Colors.yellow.withOpacity(0.75),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 60,
                            child: Center(
                                child: Text(
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              hargaTerakhir.toString(),
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
                            children: const [
                              Text(
                                "Kucing Kampung Nakal",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Dilelang butuh Uang",
                                  style: TextStyle(color: Colors.black54)),
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
                        children: const [
                          Text('Deskripsi detail barang'),
                          Text('Deskripsi',
                              style: TextStyle(color: Colors.black54))
                        ],
                      )
                    ]),
              ),
            ],
          ),
          isOpen
              ? Align(
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
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return const ModalTawar();
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            fixedSize: const Size(350, 50),
                            backgroundColor: (HexColor('#B1B2FF'))),
                        child: const Text(
                          "Tawar",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // color: Colors.red,

                    height: 100,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Pelelangan Ditutup'),
                                  content: const Text(
                                      'Pelelangan Barang ini telah ditutup oleh Admin atau Petugas'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Tutup'),
                                    ),
                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     Navigator.of(context).pop();
                                    //   },
                                    //   child: Text('Cancel'),
                                    //   style: ElevatedButton.styleFrom(
                                    //       backgroundColor: (HexColor('#B1B2FF'))),
                                    // ),
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          fixedSize: const Size(350, 50),
                          backgroundColor: (HexColor('#B1B2FF')),
                        ),
                        child: const Text(
                          "Closed",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
        ],
      ),
    );
  }
}
