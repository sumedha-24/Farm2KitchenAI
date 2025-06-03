import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:farm2kitchen/screens/auction/widgets/customButton.dart';
import 'package:farm2kitchen/screens/auction/widgets/myTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:farm2kitchen/screens/auction/auctionhome.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController prodnamecontroller = TextEditingController();
  final TextEditingController prod_desc_controller = TextEditingController();
  final TextEditingController minbidpricecontroller = TextEditingController();
  final TextEditingController endtimecontroller = TextEditingController();

  // For DateTime Picker .....................

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        endtimecontroller.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  // For Image Picker ....................

  File? _image;
  final picker = ImagePicker();

  Future imagePicker() async {
    try {
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pick != null) {
          _image = File(pick.path);
        } else {
          Fluttertoast.showToast(msg: "no image selected");
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // For Image Upload in Firebase ..........................

  Future uploadImage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('product_image')
        .child('product_image$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

  // Data Upload in Firebase Database .................

  Future sendUserDataToDB() async {
    FirebaseFirestore _auth = FirebaseFirestore.instance;
    final imgurl = await uploadImage(_image!);

    await _auth
        .collection("users-form-data")
        .add({
          "Pro_name": prodnamecontroller.text,
          "Pro_desc": prod_desc_controller.text,
          "Pro_photo": imgurl,
          "Bid_price": minbidpricecontroller.text,
          "End_time": endtimecontroller.text,
        })
        .whenComplete(
            () => Fluttertoast.showToast(msg: "User data added Successfully"))
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AuctionHome())))
        .catchError((error) =>
            Fluttertoast.showToast(msg: "something is wrong.$error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Submit the form to continue.",
                  style: TextStyle(fontSize: 22, color: Colors.green),
                ),
              
                const SizedBox(
                  height: 25,
                ),

                // For Image Pick

                Center(
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: const Color(0xFF4A148C))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _image == null
                              ? const Center(child: Text('no image selected'))
                              : Image.file(_image!),
                        ),
                        // Text('no image selected'),
                        ElevatedButton(
                            onPressed: () {
                              imagePicker();
                            },
                            child: const Text('Select Image')),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                myTextField(
                    "Product Name", TextInputType.text, prodnamecontroller),
                const SizedBox(
                  height: 30,
                ),
                myTextField("Description", TextInputType.multiline,
                    prod_desc_controller),
                    const SizedBox(
                  height: 30,
                ),
                myTextField("Min Bid Price ", TextInputType.number,
                    minbidpricecontroller),
                    const SizedBox(
                  height: 30,
                ),

                TextField(
                  controller: endtimecontroller,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Auction End Time",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                // elevated button
                customButton("Submit", () => sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
