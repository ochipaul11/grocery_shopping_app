import 'package:flutter/material.dart';
import 'package:grocery_shopping_app/pages/cart_page.dart';
import 'package:grocery_shopping_app/pages/grocery_page.dart';
import 'package:grocery_shopping_app/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        GetGroceries.routeName:(context) => GetGroceries(),
        Homepage.routeName:(context) => Homepage(),
      //  GroceryOrdering.routeName:(context) => GroceryOrdering(),
        GetCatalog.routeName:(context) => GetCatalog()
      },
      home:Homepage(),
    );
  }
}

