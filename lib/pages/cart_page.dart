import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shopping_app/models/Order.dart';
import 'package:http/http.dart' as http;

class GetCatalog extends StatefulWidget {
  const GetCatalog({Key? key}) : super(key: key);
  static const String routeName = '/cartPage';

  @override
  _GetCatalogState createState() => _GetCatalogState();
}

class _GetCatalogState extends State<GetCatalog> {
  var uri = Uri.parse("http://127.0.0.1:8000/api/orders/");
  var data;
  late List<Order> ordersData;

  Future fetchData() async {
    var res = await http.get(uri);
    final List<Order> orders = orderFromJson(res.body);
    data = jsonDecode(res.body);
    ordersData = orders;
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Some Error occured"),
                );
              }
              return ListView.builder(
                  itemCount: ordersData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                        },
                        child: Card(
                          child: Row(children: [
                            // Image.network(groceriesData[index].image,
                            //   width: 50 ,
                            // height: 50),
                            Column(children: [
                              Text(
                                "Order #"+ordersData[index].id,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                  'Total Cost :' +
                                      ordersData[index].totalPrice.toString(),
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.left),
                              Text(
                                  'Order Date :' +
                                      ordersData[index].createdAt.toString(),
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.left),
                            ]),
                          ]),
                        ));
                  });
            case ConnectionState.none:
              return Center(
                child: Text("Fetch Something"),
              );
          }
        },
      ),
    );
  }
}
