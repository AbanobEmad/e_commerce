import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/Screens/admin/Add_Product.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  static String id = "HomeAdmin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KConstColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Add_Product.id);
            },
            child: Text("Add Product"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Edit Product"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("View Orders"),
          )
        ],
      ),
    );
  }
}
