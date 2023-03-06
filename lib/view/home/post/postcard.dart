import 'package:auction_ujikom/view/home/post/postexpand.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCard extends ConsumerStatefulWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  List<String> imagepost = [
    //ambil dari firebase
    'https://www.macworld.com/wp-content/uploads/2023/01/macbook-air-m1-hero01-100866889-orig.jpg?quality=50&strip=all&w=1024',
    'https://id.pinterest.com/pin/561331541068354390/'
  ];


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PostExpandView(

          )
        ));
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
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: CarouselSlider.builder(
                        itemCount: imagepost.length ,
                        options: CarouselOptions(autoPlay: true,),
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Container(
                          child: Image.network(
                            imagepost[itemIndex],
                            fit: BoxFit.contain,
                            ),
                        ),


                        // items: [1,2,3].map((i){
                        //   return Builder(
                        //     builder: (BuildContext context) {
                        //       return Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         margin: EdgeInsets.symmetric(horizontal: 5.0),
                        //         child: Text('text $i'),
                        //       );
                        //     },
                        //   );
                        // }).toList,
                      )
                      // child: Image.network(
                      //   'https://www.macworld.com/wp-content/uploads/2023/01/macbook-air-m1-hero01-100866889-orig.jpg?quality=50&strip=all&w=1024',
                      //   fit: BoxFit.contain,
                      // ),
                      ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10))),
                        child: Text(
                          "Rp. 700.000",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Judul
                    Text(
                      "Kucing Kampung Nakal",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Dilelang butuh Uang",
                        style: TextStyle(color: Colors.black54)),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
