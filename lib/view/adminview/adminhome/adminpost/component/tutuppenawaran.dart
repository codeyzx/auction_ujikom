import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ModalTutupPenawaran extends ConsumerStatefulWidget {
  const ModalTutupPenawaran({Key? key}) : super(key: key);

  @override
  ConsumerState<ModalTutupPenawaran> createState() =>
      _ModalTutupPenawaranState();
}

class _ModalTutupPenawaranState extends ConsumerState<ModalTutupPenawaran> {
  TextEditingController tawarPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 200.h,
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Tutup Penawaran?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
              '*Foto serta deskripsi akan hilang dan tidak dapat dilihat lagi oleh user.'),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Batal
              ElevatedButton(
                onPressed: () {
                  //Navigate pop
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(150, 40)),
                child: const Text('Batal', style: TextStyle(color: Colors.black)),
              ),

              //Confirm Tawar
              ElevatedButton(
                  onPressed: () {
                    //change status from "open" to "closed"
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (HexColor('#EA5A5A')),
                      fixedSize: const Size(150, 40)),
                  child: const Text('Confirm', style: TextStyle(color: Colors.white)))
            ],
          )
        ]),
      ),
    );
  }
}
