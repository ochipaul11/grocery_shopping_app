import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shopping_app/models/Grocery.dart';
import 'package:http/http.dart' as http;

class GroceryOrdering extends StatefulWidget {
  const GroceryOrdering({Key? key, required this.grocery}) : super(key: key);
  final Grocery grocery;

  @override
  _GroceryOrderingState createState() => _GroceryOrderingState();
}

class _GroceryOrderingState extends State<GroceryOrdering> {
  var uri = Uri.parse("http://127.0.0.1:8000/api/order");

  late int dropDownValue = 1;

  Future postOrder(int groceryId, int userId, int quantity, int totalPrice) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/order/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        "grocery_id": groceryId,
        "user_id": userId,
        "quantity": quantity,
        "total_price": totalPrice
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      confirmOrder(context);
      return (response.body.toString());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  void confirmOrder(context) {
    showDialog(context: context,
               builder: (BuildContext context){
      return AlertDialog(
        content: Text("Order succeffully added"),
        actions: <Widget>[
          RaisedButton(
            child: Icon(Icons.cancel),
            color: Colors.green,
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
               });
  }

  TextEditingController _itemCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var items = [5, 10, 15, 20];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context,false),),
        title: Text(
          widget.grocery.name,
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      widget.grocery.image,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      widget.grocery.description,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(50, 50, 50, 0),
                        child: TextFormField(
                          controller: _itemCountController,
                          decoration: InputDecoration(
                              hintText: "Enter number of items",
                              hintStyle: TextStyle(color: Colors.black),
                              labelText: "Items",
                              labelStyle: TextStyle(color: Colors.grey)),
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(80, 100, 80, 0),
                      child: MaterialButton(
                        onPressed: () {
                          print('Button pressed ...');
                          postOrder(
                              widget.grocery.id,
                              2,
                              int.parse(_itemCountController.text),
                              int.parse(_itemCountController.text)*widget.grocery.price);
                        },
                        child: Text('Add to cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

addToCart(String itemName, int itemAmount) {}
