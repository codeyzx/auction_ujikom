import 'package:auction_ujikom/view/home/post/postcard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageView extends ConsumerStatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomepageView> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<HomepageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: const [],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.05,
              padding: EdgeInsets.fromLTRB(0, 7.h, 0, 0),
              decoration: const BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Text('Auction is Live!',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const PostCard(),
          const SizedBox(height: 20),
          const PostCard(),
          const SizedBox(
            height: 20,
          ),
          const PostCard(),
        ],
      ),
    );
  }
}
