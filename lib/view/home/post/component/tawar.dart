
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ModalTawar extends ConsumerStatefulWidget {
  const ModalTawar({Key? key}) : super(key: key);

  @override
  ConsumerState<ModalTawar> createState() => _ModalTawarState();
}

class _ModalTawarState extends ConsumerState<ModalTawar> {
  TextEditingController tawarPostController = TextEditingController();

  bool confirmTawar = false;

  @override
  Widget build(BuildContext context) {
    int hargaAwal = 15000000;
    int hargaTerakhir = 2000000;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250.h,
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Tawar Barang',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text('*harga barang harus lebih tinggi dari harga awal'),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              controller: tawarPostController,
              onChanged: (value) {
                print(value);
                print(hargaTerakhir);
                if (int.parse(value) > hargaTerakhir) {
                  print("masuk");
                  setState(() {
                    confirmTawar = true;
                  });

                }
                else if (int.parse(value) < hargaTerakhir){
                  setState(() {
                    confirmTawar = false;
                  });
                }

              },
              minLines: 1,
              // any number you need (It works as the rows for the text area)
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              inputFormatters: const [],

              toolbarOptions: const ToolbarOptions(selectAll: false, paste: false),
              maxLines: null,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: hargaTerakhir.toString(),
                prefixText: 'IDR. ',
              ),
            ),
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
                child: const Text('Batal'),
              ),

              //Confirm Tawar
              ElevatedButton(
                onPressed: () {
                  print(confirmTawar);
                  confirmTawar ? Navigator.pop(context) : null;
                },
                style: confirmTawar
                    ? ElevatedButton.styleFrom(
                        backgroundColor: (HexColor('#B1B2FF')),
                        fixedSize: const Size(160, 40))
                    : ElevatedButton.styleFrom(
                        backgroundColor: (HexColor('#FFFFFF')),
                        fixedSize: const Size(160, 40)),
                child: const Text('Confirm'),
              )
            ],
          )
        ]),
      ),
    );
  }
}
