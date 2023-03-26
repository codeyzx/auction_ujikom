import 'package:flutter/material.dart';
import 'package:auction_ujikom/controller/itemController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'adminpost/adminpostcard.dart';

class AdminHomeView extends ConsumerStatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends ConsumerState<AdminHomeView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(itemControllerProvider.notifier).getItem();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemControllerProvider);
    return Scaffold(
        body: isLoading != true
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    AdminPostCard(items: items[index]),
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
  }
}
