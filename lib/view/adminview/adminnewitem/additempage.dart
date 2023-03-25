import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:auction_ujikom/controller/authController.dart';

import '../../../controller/itemController.dart';


class AddItemPageView extends ConsumerStatefulWidget {
  const AddItemPageView({Key? key}) : super(key: key);

  @override
  ConsumerState<AddItemPageView> createState() => _AddItemPageViewState();
}


class _AddItemPageViewState extends ConsumerState<AddItemPageView> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController titleItemController = TextEditingController();
  final TextEditingController hargaAwalController = TextEditingController();
  final TextEditingController aboutItemController = TextEditingController();
  final TextEditingController aboutDetailItemController = TextEditingController();

  String imageUrl = '';

  @override
  void dispose() {
    titleItemController.dispose();
    hargaAwalController.dispose();
    aboutItemController.dispose();
    aboutDetailItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);


    return Scaffold(
        appBar: AppBar(
            actions: [],
            title: Text('Tambah Barang Baru')
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20),
          children: [
            Center(

              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      //Field Upload Foto
                      InkWell(
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Icon(Icons.camera_alt_rounded),
                              SizedBox(height: 5,),
                              Text('Upload Foto'),
                              SizedBox(height: 20,)
                            ],
                          ),
                        ),
                        onTap: () async {
                          //1. Pick and Crop the image
                          //2. Upload the image to Firebase storage
                          //3. Get the URL of the uploaded image
                          //4. Store image URL in items collection

                          // 1. Pick Image s

                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery, imageQuality: 70);
                          print('${file?.path}');

                          String uniqueImageFileName = DateTime
                              .now()
                              .millisecondsSinceEpoch
                              .toString();

                          // 2. Upload to Firebase

                          //Get the reference of storage root
                          Reference referenceRoot = FirebaseStorage.instance
                              .ref();
                          Reference referenceDirImages = referenceRoot.child(
                              'item_images');

                          //Create a reference for the image to be stored
                          Reference referenceImageToUpload = referenceDirImages
                              .child(uniqueImageFileName);

                          referenceImageToUpload.putFile(File(file!.path));

                          try {
                            await referenceImageToUpload.putFile(File(file!
                                .path));
                            imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                          } catch (error) {

                          }
                        },
                      ),

                      Text('Judul Barang'),
                      TextFormField(
                        controller: titleItemController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Judul harus diisi';
                          }
                          else if (value.length < 10) {
                            return 'Judul minimal 10 huruf';
                          }
                          else if (value.length > 24) {
                            return 'Judul maksimal 24 huruf';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Text('Masukkan Harga Awal'),
                      TextFormField(
                        controller: hargaAwalController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Isi harga dengan benar';
                          }
                          final n = int.tryParse(value);
                          if (n == null) {
                            return 'Please enter a valid number';
                          }
                          return null;

                        },

                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Text('Deskripsi Barang'),

                      TextFormField(
                        controller: aboutItemController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Isi deskripsi barang dengan benar';
                          }
                        },
                        maxLength: 64,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),

                      SizedBox(height: 20,),


                      Text('Detail Deskripsi Barang'),

                      TextFormField(
                        controller: aboutDetailItemController,

                        minLines: 10,
                        // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 840,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: EdgeInsets.fromLTRB(20, 25, 0, 5),
                          hintText: 'Write your post messege here...',

                        ),
                      ),

                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              try {
                                await ref.read(itemControllerProvider.notifier)
                                    .addItem(uid: users.uid.toString(),
                                    title: titleItemController.text.trim(),
                                    about: aboutItemController.text.trim(),
                                    about_detail: aboutDetailItemController.text.trim(),
                                    picture: imageUrl.toString(),
                                    harga_awal: double.tryParse(hargaAwalController.text));

                                print(titleItemController.text);

                                Navigator.pushReplacementNamed(context, '/adminhome');

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Item Created'),
                                        content: Text(
                                            'Success! Your item has been successfully created and is now live for bidding. Good luck!'),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Close'))
                                        ],
                                      );
                                    });

                              }
                              catch (error) {
                                print(error);
                              }
                            }
                          },
                          child: Text(
                              'Submit', style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (HexColor('#B1B2FF')),
                              fixedSize: Size(160, 40)),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
