import 'package:ecommerce/CustomWidget/CustomTextField.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Services/Store.dart';
import 'package:flutter/material.dart';
class Add_Product extends StatelessWidget {
  static String id="Add_product";
  String _name,_price,_description,_category,_location;
  final Store _store= Store();
  final GlobalKey<FormState>_globalKey=new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: "Product Name",
              OnClick: (value){
                _name=value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Peice",
              OnClick: (value){
                _price=value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Description",
              OnClick: (value){
                _description=value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Category",
              OnClick: (value){
                _category=value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Location",
              OnClick: (value){
                _location=value;
              },
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
                onPressed:(){
                  if(_globalKey.currentState.validate())
                    {
                      _globalKey.currentState.save();
                      _store.addProduct(Product(
                        pname: _name,
                        pprice: _price,
                        pcategory: _category,
                        pdescription: _description,
                        plocation: _location,
                      ));
                    }
                },
            child: Text("Add Product"),
            )
          ],
        ),
      ),
    );
  }
}
