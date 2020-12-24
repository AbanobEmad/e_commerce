import 'package:ecommerce/Models/Product.dart';
import 'package:flutter/material.dart';
class ProductInfo extends StatefulWidget {
  static String id="ProductInfo";

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {

  @override
  Widget build(BuildContext context) {
    Product product=ModalRoute.of(context).settings.arguments;
    print(product.pname);
    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 4,
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*.75,
                child: Positioned.fill(child: Image(image: AssetImage(product.plocation),fit: BoxFit.fill,)),
              )
              ),
        ),
        Material(
          child: Container(
            height: MediaQuery.of(context).size.height*.1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,30,20,0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Discover".toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Icon(Icons.shopping_cart)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
