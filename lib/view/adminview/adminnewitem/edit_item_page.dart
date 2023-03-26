import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../controller/authController.dart';
import '../../../controller/itemController.dart';
import '../../../model/items.dart';

class EditItemPageView extends ConsumerStatefulWidget {
  final Items item;

  const EditItemPageView({Key? key, required this.item}) : super(key: key);

  @override
  ConsumerState<EditItemPageView> createState() => _EditItemPageViewState();
}

class _EditItemPageViewState extends ConsumerState<EditItemPageView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController title;
  late TextEditingController hargaAwal;
  late TextEditingController aboutItem;
  late TextEditingController aboutDetailItem;

  String imageUrl = '';

  @override
  void initState() {
    getAllItem();
    super.initState();
    title = TextEditingController(text: widget.item.title.toString());
    hargaAwal = TextEditingController(text: widget.item.harga_awal.toString());
    aboutItem = TextEditingController(text: widget.item.about.toString());
    aboutDetailItem = TextEditingController(text: widget.item.about_detail.toString());
    imageUrl = widget.item.picture.toString();
  }

  Future<void> getAllItem() async {
    await ref.read(itemControllerProvider.notifier).getItem();
  }

  @override
  void dispose() {
    title.dispose();
    hargaAwal.dispose();
    aboutItem.dispose();
    aboutDetailItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: const [], title: const Text('Edit Barang')),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: [
            Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              imageUrl == ''
                                  ? Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 70);
                          print('${file?.path}');

                          String uniqueImageFileName = DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot = FirebaseStorage.instance.ref();
                          Reference referenceDirImages = referenceRoot.child('item_images');

                          Reference referenceImageToUpload = referenceDirImages.child(uniqueImageFileName);

                          referenceImageToUpload.putFile(File(file!.path));

                          try {
                            await referenceImageToUpload.putFile(File(file.path));
                            final value = await referenceImageToUpload.getDownloadURL();
                            Logger().i(value);
                            setState(() {
                              imageUrl = value;
                            });
                          } catch (error) {
                            Logger().e(error);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Judul Barang'),
                      TextFormField(
                        controller: title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Judul harus diisi';
                          } else if (value.length < 10) {
                            return 'Judul minimal 10 huruf';
                          } else if (value.length > 24) {
                            return 'Judul maksimal 24 huruf';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Masukkan Harga Awal'),
                      TextFormField(
                        enabled: false,
                        controller: (hargaAwal),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Deskripsi Barang'),
                      TextFormField(
                        controller: aboutItem,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Isi deskripsi barang dengan benar';
                          }
                          return null;
                        },
                        maxLength: 64,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Detail Deskripsi Barang'),
                      TextFormField(
                        controller: aboutDetailItem,
                        minLines: 10,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 840,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          contentPadding: const EdgeInsets.fromLTRB(20, 25, 0, 5),
                          hintText: 'Write your post messege here...',
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              try {
                                await ref.read(itemControllerProvider.notifier).updateItem(
                                    context: context,
                                    uid: widget.item.itemid.toString(),
                                    title: title.text.trim(),
                                    about: aboutItem.text.trim(),
                                    aboutDetail: aboutDetailItem.text.trim(),
                                    picture: imageUrl.toString(),
                                    hargaAwal: double.tryParse(hargaAwal.text));

                                if (!mounted) return;

                                Navigator.pushReplacementNamed(context, '/adminhome');

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Item Edited'),
                                        content: const Text('Success! Your item has been successfully edited.'),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Close'))
                                        ],
                                      );
                                    });
                              } catch (error) {
                                print(error);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (HexColor('#B1B2FF')), fixedSize: const Size(160, 40)),
                          child: const Text('Submit', style: TextStyle(color: Colors.black)),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
