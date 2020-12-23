import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Services/Store.dart';
import 'package:flutter/material.dart';

import '../../Constains.dart';
import 'package:ecommerce/Screens/admin/Edit_Product.dart';

class ManagePeoduct extends StatefulWidget {
  static String id = "Manage_Product";

  @override
  _ManagePeoductState createState() => _ManagePeoductState();
}

class _ManagePeoductState extends State<ManagePeoduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product>products=[];
          for(var doc in snapshot.data.docs){
            var _data=doc.data();
            products.add(Product(
              Pid: doc.id,
              pname: _data[KProductName],
              pprice: _data[KProductPrice],
              pdescription: _data[KProductDescription],
              pcategory: _data[KProductCaTegory],
              plocation: _data[KProductLocation],
            ));
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              childAspectRatio: .8
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, EtidProduct.id,arguments: products[index]);
                          },
                        ),
                        MyPopupMenuItem(
                            child: Text("Delet"),
                          Onclick: (){
                              _store.deleteProduct(products[index].Pid);
                              Navigator.pop(context);
                          },
                        )
                      ]);

                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].plocation)
                          ,)
                    ),
                    Positioned(
                      bottom: 0,
                        child: Opacity(
                          opacity: .5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(products[index].pname,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Text('\$ ${products[index].pprice}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(
            child: Text("Lodaing"),
          );
        }
      },
    ));
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T>
{
  final Widget child;
  final Function Onclick;
  MyPopupMenuItem ({@required this.child,@required this.Onclick}):super(child:child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMuneItemState();
  }
}
class MyPopupMuneItemState<T,PopupMenuItem> extends PopupMenuItemState<T,MyPopupMenuItem<T>>
{

  @override
  void handleTap() {
    widget.Onclick();
  }
}