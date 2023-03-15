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
    return Scaffold(
      appBar: AppBar(title: Text('Ambil dari Judul document firebase')),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
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
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  'IDR 37.000.000')),
                        ),
                        Container(
                            color: Colors.yellow.withOpacity(0.75),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 60,
                            child: Center(
                                child: Text(
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              'Harga Akhir',
                              softWrap: true,
                            )))
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                      LikeButton()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deskripsi detail barang'),
                      Text('Deskripsi', style: TextStyle(color: Colors.black54))
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
                    showModalBottomSheet(isScrollControlled: true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(
                        20))),context: context, builder: (context){
                      return ModalTawar();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      fixedSize: Size(350, 50),
                      backgroundColor: (HexColor('#B1B2FF'))),
                  child: const Text(
                    "Tawar",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
