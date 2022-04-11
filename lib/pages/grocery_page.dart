import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopping_app/models/Grocery.dart';
import 'package:grocery_shopping_app/pages/grocery_ordering_page.dart';
import 'package:http/http.dart' as http;

class GetGroceries extends StatefulWidget {
  const GetGroceries({Key? key}) : super(key: key);
  static const String routeName = '/groceriesPage';

  @override
  _GetGroceriesState createState() => _GetGroceriesState();
}

class _GetGroceriesState extends State<GetGroceries> {
  var uri = Uri.parse('http://127.0.0.1:8000/api/groceries/');
  late List<Grocery> groceriesData;
  var data;

  Future fetchData() async {
    var res = await http.get(uri);

    // if (res.statusCode == 200) {
    final List<Grocery> groceries = groceryFromJson(res.body);
    data = jsonDecode(res.body);
    groceriesData = groceries;
    return data;
    // }
    throw Exception(Text("No response from Server!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Groceries')),
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
                  itemCount: groceriesData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => GroceryOrdering(
                                        grocery: groceriesData[index],
                                      ))));
                        },
                        child: Card(
                          child: Row(children: [
                            // Image.network(groceriesData[index].image,
                            //   width: 50 ,
                            // height: 50),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(groceriesData[index].image),
                            ),
                            Column(children: [
                              Text(
                                groceriesData[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                  'Ksh ' +
                                      groceriesData[index].price.toString(),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
