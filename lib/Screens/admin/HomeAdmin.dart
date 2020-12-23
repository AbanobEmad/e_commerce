import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/Screens/admin/Add_Product.dart';
import 'package:ecommerce/Screens/admin/Manage_product.dart';
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
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text("Add Product"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManagePeoduct.id);
            },
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
