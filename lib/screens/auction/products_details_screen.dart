import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farm2kitchen/screens/auction/widgets/myTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './allbidlist.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _BidController = TextEditingController();


  Future Biditem() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Bid-list");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
          "name": widget._product["Product-name"],
          "bid-price": _BidController.text,
          "images": widget._product["Product-photo"],
        })
        .whenComplete(
            () => Fluttertoast.showToast(msg: "User data added Successfully"))
        .catchError((error) =>
            Fluttertoast.showToast(msg: "something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              Divider(),
              const SizedBox(
                height: 15,
              ),
              AspectRatio(
                aspectRatio: 2,
                child: Container(
                  color: Colors.grey[200],
                  child: Image.network(widget._product["Product-photo"]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget._product['Product-name'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Description of this product : ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.pink[900]),
              ),
              Text(
                widget._product['product-description'],
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: "Roboto",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Bid Above :"
                "  ${widget._product['Min-Bid-price'].toString()} INR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.teal.shade900),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "\t\t\t\t\t\t\t" "Auction End Date : " +
                    widget._product['Endtime'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              SizedBox(
                height: 10,
              ),
              myTextField(
                  "Your Bid Price : ", TextInputType.number, _BidController),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 1,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Biditem(),
                  child: Text(
                    "Bid Here",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 3,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context, CupertinoPageRoute(builder: (_) => AllBidList())),
                  child: Text(
                    "Show All Bid List",
                    style: TextStyle(color: Colors.red, fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      )),
    );
  }
}
