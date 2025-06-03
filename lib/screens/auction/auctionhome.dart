import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './user_form.dart';
import './products_details_screen.dart';

import 'package:farm2kitchen/widgets/user_drawer/user_drawer.dart';
import 'package:farm2kitchen/widgets/app_bar/custom_app_bar.dart';
import 'package:farm2kitchen/widgets/bottom_nav_bar/bottom_nav_bar.dart';

import 'package:farm2kitchen/settings/router/utils/router_utils.dart';

import 'package:text_to_speech/text_to_speech.dart';

class AuctionHome extends StatefulWidget {
  @override
  _AuctionHomeState createState() => _AuctionHomeState();
}

class _AuctionHomeState extends State<AuctionHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  TextToSpeech tts = TextToSpeech();


  fetchProducts() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("users-form-data").get();
    setState(() {
      for (var i = 0; i < qn.docs.length; i++) {
        _products.add({
          "Product-name": qn.docs[i]["Pro_name"],
          "product-description": qn.docs[i]["Pro_desc"],
          "Min-Bid-price": qn.docs[i]["Bid_price"],
          "Endtime": qn.docs[i]["End_time"],
          "Product-photo": qn.docs[i]["Pro_photo"],
        });
      }
    });

    return qn.docs;
  }

  
  @override
  void initState() {
    fetchProducts();
    super.initState();
  }


   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: CustomAppBar(
          title: APP_PAGE.home.routePageTitle, scaffoldKey: _scaffoldKey),
      bottomNavigationBar: BottomNavBar(
        navItemIndex: 1,
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  fillColor: Colors.blueGrey,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.pink)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.pink)),
                  hintText: "Search products here",
                  hintStyle: TextStyle(fontSize: 15),
                ),
                // CupertinoPageRoute(builder: (_) => SearchScreen())),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // For Carousel Image ..................

            
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetails(_products[index]))),
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 5 / 3,
                              child: Container(
                                color: Colors.amberAccent,
                                child: Image.network(
                                    _products[index]["Product-photo"]),
                              ),
                            ),
                            Text(
                              "${_products[index]["Product-name"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey[800]),
                            ),
                            Text(
                              "Min Bid-"
                                      "${_products[index]["Min-Bid-price"]}" +
                                  " INR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.blue[00]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      )),
      floatingActionButton: buildNavigateButton(),
    );
  }

  Widget buildNavigateButton() => FloatingActionButton(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => const UserForm()));
          // BottomNavController()));
        },
        child: const Icon(Icons.add),
      );
}
