
import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Provider/CartProduct.dart';
import 'package:ecommerce/Screens/user/CartView.dart';
import 'package:ecommerce/Screens/user/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProductInfo extends StatefulWidget {
  static String id="ProductInfo";

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity=1;
  @override
  Widget build(BuildContext context) {
    Product product=ModalRoute.of(context).settings.arguments;
    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 4,
            child: Scaffold(
              body: ListView(
                children: <Widget>
                [
                  Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height*.75,
                  child: Image(image: AssetImage(product.plocation),fit: BoxFit.fill,),
                ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(product.pname,style: TextStyle(fontSize: 18)),
                            Text("Description",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            Text(product.pdescription,style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Price",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
                            Container(
                              height: 80,
                              width: 80,
                              color: KConstColor2,
                              child: Center(child: Text(product.pprice,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: KConstColor,
                              child: GestureDetector(
                                onTap: (){

                                  AddQunatity();
                                },
                                child: SizedBox(
                                  child: Icon(Icons.add_circle_outline,size: 35,),
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                            child: Text(_quantity.toString(),style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                          ),
                          ClipOval(
                            child: Material(
                              color: KConstColor,
                              child: GestureDetector(
                                onTap: (){
                                  RemoveQuantity();
                                },
                                child: SizedBox(
                                  child: Icon(Icons.remove_circle_outline,size: 35,),
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Builder(
                      builder:(context)=> RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) )
                        ),
                        onPressed: (){

                          AddCartProduct(context,product);
                        },
                        color: KConstColor,
                        child: Text("Add Cart".toUpperCase(),style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  )
                ]
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
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back_ios)),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, CartView.id);
                    },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void AddQunatity() {
    setState(() {
      _quantity++;
    });
  }

  void RemoveQuantity() {
    if(_quantity>1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void AddCartProduct(context,Product product) {
    CartProduct _cartProduct=Provider.of<CartProduct>(context,listen: false);
    bool Exist=false;
    var ProductCart =_cartProduct.products;
    for(var productcartItem in ProductCart)
      {
        if(productcartItem.pname==product.pname)
          Exist=true;
      }
    if(Exist)
      {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('you\'add this product before'),));
      }
    else
      {
        product.pquantity=_quantity;
        _cartProduct.addProduct(product);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added To Cart"),));
      }

  }
}
