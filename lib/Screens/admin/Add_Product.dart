import 'package:ecommerce/CustomWidget/CustomTextField.dart';
import 'package:flutter/material.dart';
class Add_Product extends StatelessWidget {
  static String id="Add_product";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            hint: "Product Name",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            hint: "Product Peice",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            hint: "Product Description",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            hint: "Product Category",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            hint: "Product Location",
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
              onPressed:(){

              },
          child: Text("Add Product"),
          )
        ],
      ),
    );
  }
}
