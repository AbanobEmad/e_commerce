
import 'package:ecommerce/Models/Product.dart';
import 'package:flutter/material.dart';

List<Product> GetProduct(String TypeCaTegory,List<Product> allProudct)
{
  List<Product>_product=[];
  try{
  for(var product in allProudct)
  {
    if(product.pcategory==TypeCaTegory)
      {
        _product.add(product);
      }
  }}
  on Error catch(ex){
    print(ex);
  }
  return _product;
}