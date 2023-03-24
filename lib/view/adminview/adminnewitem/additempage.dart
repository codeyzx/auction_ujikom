import 'dart:io';
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


class AddItemPageView extends ConsumerStatefulWidget {
  const AddItemPageView({Key? key}) : super(key: key);

  @override
  ConsumerState<AddItemPageView> createState() => _AddItemPageViewState();
}

class _AddItemPageViewState extends ConsumerState<AddItemPageView> {
  final _formKey = GlobalKey<FormState>();

  File? pickedImage;
  UploadTask? uploadTask;
  String? photoUrl;

  //
  // Future _pickImage(ImageSource source, ) async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //         source: source, imageQuality: 85, maxWidth: 400, maxHeight: 400);
  //     if (image == null) return;
  //     File? img = File(image.path);
  //     img = await _cropImage(image: img);
  //
  //     if (img != null) {
  //       final path = 'fotobarang/${img.path.toString()}';
  //       final finalImage = File(img.path);
  //
  //       Reference reff = FirebaseStorage.instance.ref().child(path);
  //       final value = await reff.putFile(finalImage);
  //
  //       // final snapshot = await uploadTask!.whenComplete(() {});
  //
  //       final url = await value.ref.getDownloadURL();
  //       await FirebaseFirestore.instance
  //           .collection('items')
  //           .doc()
  //           .set({
  //         'picture': url.toString(),
  //       });
  //
  //       // await ref.read(authControllerProvider.notifier).getUsers(uid: docId.toString());
  //
  //       // Logger().i(url);
  //       setState(() {
  //         photoUrl = url;
  //       });
  //       // return photoUrl ;
  //       // photoUrl = await uploadImage();
  //       // setState(() {});
  //     }
  //     // setState(() {
  //     //   pickedImage = img;
  //     //   Navigator.of(context).pop();
  //     // });
  //     // if (await pickedImage!.exists()) {
  //     //   photoUrl = await uploadImage();
  //     //   setState(() {});
  //     // }
  //   } on PlatformException catch (e) {
  //      Logger().e(e);
  //   }
  // }
  //
  // Future<File?> _cropImage({required File image}) async {
  //   CroppedFile? croppedImage = await ImageCropper().cropImage(
  //       sourcePath: image.path,
  //       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //       maxWidth: 300,
  //       maxHeight: 300);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }
  //
  // Future<void> uploadImage() async {
  //   final path = 'userprofilepicture/${pickedImage!.path}';
  //   final finalImage = File(pickedImage!.path);
  //
  //   Reference reff = FirebaseStorage.instance.ref().child(path);
  //   final value = await reff.putFile(finalImage);
  //
  //   // final snapshot = await uploadTask!.whenComplete(() {});
  //
  //   final photoUrl = await value.ref.getDownloadURL();
  //
  //   Logger().i(photoUrl);
  //   // return photoUrl ;
  // }

  @override
  Widget build(BuildContext context) {

    // final users = ref.watch(authControllerProvider);

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
                          width: MediaQuery.of(context).size.width,
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
                          // await _pickImage(ImageSource.gallery);


                        },
                      ),

                      Text('Judul Barang'),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Judul',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Text('Masukkan Harga Awal'),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Rp-',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Text('Deskripsi Barang'),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Singkat Barang',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        ),
                      ),

                      SizedBox(height: 20,),


                      Text('Detail Deskripsi Barang'),

                      TextFormField(

                        minLines: 10,
                        // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 840,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Detail Barang',

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                          hintText: 'Write your post messege here...',

                        ),
                      ),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          child: Text('Submit', style: TextStyle(color: Colors.black)),
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
