import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/CustomWidget/CustomMenu.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Provider/CartProduct.dart';
import 'package:ecommerce/Screens/user/productInfo.dart';
import 'package:ecommerce/Services/Store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  static String id = "CartView";

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    double price = 0;
    List<Product> products = Provider.of<CartProduct>(context).products;
    price = Price(products);
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrain) {
        if (products.isNotEmpty) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (Detalis){
                          double dx=Detalis.globalPosition.dx;
                          double dy=Detalis.globalPosition.dy;
                          double dx2=MediaQuery.of(context).size.width-dx;
                          double dy2=MediaQuery.of(context).size.height-dy;
                          showMenu(
                              context: context
                              , position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                              items: [
                                MyPopupMenuItem(
                                  child: Text("Edit"),
                                  Onclick: (){
                                    Product _product=products[index];
                                    Navigator.pop(context);
                                    Provider.of<CartProduct>(context,listen: false).deletProduct(products[index]);
                                    Navigator.pushNamed(context, ProductInfo.id,arguments: _product);
                                  },
                                ),
                                MyPopupMenuItem(
                                  child: Text("Delet"),
                                  Onclick: (){
                                    Navigator.pop(context);
                                    Provider.of<CartProduct>(context,listen: false).deletProduct(products[index]);
                                  },
                                )
                              ]);

                        },
                        child: Container(
                          height: ScreenHeight * .15,
                          width: ScreenWidth,
                          color: KConstColor2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: ScreenHeight * .15 / 2,
                                    backgroundImage:
                                        AssetImage(products[index].plocation),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          products[index].pname,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(products[index].pprice,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(products[index].pquantity.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  width: ScreenWidth,
                  height: ScreenHeight * .1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Peice",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(price.toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),

                      Column(children: <Widget>[
                        Text("Delvery",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("10",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        )
                      ]),
                      Column(
                        children: <Widget>[
                          Text("Total",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text((price + 10).toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Builder(
                builder :(context)=> ButtonTheme(
                  minWidth: ScreenWidth,
                  height: 70,
                  child: RaisedButton(
                    onPressed: ()
                    {
                      ShowCustomDialog(products,context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    color: KConstColor,
                    child: Text(
                      "Order".toUpperCase(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return Center(
              child: Text(
            "Cart is empty".toUpperCase(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ));
        }
      }),
    );
  }

  Price(List<Product> products) {
    double price = 0;
    for (var product in products) {
      price += (double.parse(product.pprice)) * product.pquantity;
    }
    return price;
  }

  void ShowCustomDialog(List<Product> products,context) async
  {
    AlertDialog alertDialog=AlertDialog(
      actions: <Widget>[
        MaterialButton(
            onPressed: ()
          {
            Navigator.pop(context);
          },
          child: Text("Cancel".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
        ),
        MaterialButton(
          onPressed: ()
          {
            try{
              Store _store = Store();
              _store.StorOrder({
                KTotallPrice : (Price(products)+10).toString(),
              }, products);
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("The Orders is Done")));
              Navigator.pop(context);
            }
            catch(ex){
              print(ex.toString());
            }
          },
          child: Text("Confirm".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
        )
      ],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Text("The Total Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          Text((Price(products)+10).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
        ],
      ),
      title:  Center(child: Text("Orders"),),
    );
    await showDialog(context: context,builder: (context)
    {
      return alertDialog;
    }
    );
  }
}
