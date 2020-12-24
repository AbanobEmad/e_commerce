import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/FunctionGetProduct.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Screens/user/productInfo.dart';
import 'package:flutter/material.dart';
Widget ViewProduct (String CaTegory,List<Product> allProudct)
{
  List<Product> products=[];
  products = GetProduct(CaTegory,allProudct );
  return Container(
    color: KConstColor2,
    child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .8,
        ),
        itemCount:products.length ,
        itemBuilder: (context,index)=>Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: KConstColor)
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Image(image: AssetImage(products[index].plocation))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Text(products[index].pname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        Text(products[index].pprice,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    ),
  );

}