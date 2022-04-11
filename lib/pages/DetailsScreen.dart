import 'package:flutter/material.dart';
import 'package:grocery_shopping_app/models/Grocery.dart';



class DetailScreen extends StatelessWidget {
  final Grocery item;
  const DetailScreen({required Key key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
      ),
      body: Center(
        child: Column(
            children:[
              // Text(item.longText),
              // Image.network(item.imageUrl,fit: BoxFit.fill,),
            ]
        ),
      ),
    );
  }
}