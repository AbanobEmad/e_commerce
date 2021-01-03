import 'package:ecommerce/Models/Product.dart';
import 'package:flutter/material.dart';
class CartProduct extends ChangeNotifier
{
  List<Product> products =[];
  addProduct(Product _product)
  {
    products.add(_product);
    notifyListeners();
  }
  deletProduct(product){
    products.remove(product);
    notifyListeners();
  }
}