import 'package:ecommerce/CustomWidget/CustomTextField.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Provider/ModelHud.dart';
import 'package:ecommerce/Services/Store.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class AddProduct extends StatelessWidget {
  static String id="Add_product";
  String _name,_price,_description,_category,_location;
  final Store _store= Store();
  final GlobalKey<FormState>_globalKey=new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoadind,
        child: Form(
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
                  onPressed:()async{
                    final _modelHud=Provider.of<ModelHud>(context,listen: false);
                    _modelHud.changeisLoadind(true);
                    if(_globalKey.currentState.validate())
                      {
                        _globalKey.currentState.save();
                        await _store.addProduct(Product(
                          pname: _name,
                          pprice: _price,
                          pcategory: _category,
                          pdescription: _description,
                          plocation: _location,
                        ));
                        _modelHud.changeisLoadind(false);
                      }
                    _modelHud.changeisLoadind(false);
                  },
              child: Text("Add Product"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
