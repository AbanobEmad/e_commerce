import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/CustomWidget/ViewProduct.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Services/Store.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  static String id="Home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tabBarIndex=0;
  final Store _store =Store();
  int _indexNavigation=0;
  List<Product> _products=[];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                fixedColor: KConstColor,
                currentIndex: _indexNavigation,
                onTap: (value){
                  setState(() {
                    _indexNavigation=value;
                  });
                },
                elevation: 5,
                items:const <BottomNavigationBarItem> [
                  BottomNavigationBarItem(
                      label: "test1",
                      icon: Icon(Icons.person),
                      backgroundColor: Colors.green
                  ),
                  BottomNavigationBarItem(
                      label: "test2",
                      icon: Icon(Icons.person),
                      backgroundColor: Colors.blue
                  ),
                  BottomNavigationBarItem(
                      label: "test3",
                      icon: Icon(Icons.person),
                      backgroundColor: Colors.yellow
                  ),
                  BottomNavigationBarItem(
                      label: "test4",
                      icon: Icon(Icons.person),
                      backgroundColor: Colors.red
                  ),
                ],
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  onTap: (value){
                    setState(() {
                      _tabBarIndex =value;
                    });
                  },
                  tabs: <Widget>[
                    Text("Jackets",
                        style: TextStyle(color: _tabBarIndex==0? Colors.black : KUnActiveColor,
                          fontSize: _tabBarIndex==0? 16:null,
                        )
                    ),
                    Text("Trousers",
                        style: TextStyle(color: _tabBarIndex==1? Colors.black : KUnActiveColor,
                          fontSize: _tabBarIndex==1? 16:null,
                        )
                    ),
                    Text("T-Shirts",
                        style: TextStyle(color: _tabBarIndex==2? Colors.black : KUnActiveColor,
                          fontSize: _tabBarIndex==2? 16:null,
                        )
                    ),
                    Text("Shose",
                        style: TextStyle(color: _tabBarIndex==3? Colors.black : KUnActiveColor,
                          fontSize: _tabBarIndex==3? 16:null,
                        )
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  JecketView(),
                  ViewProduct(KJackets,_products),
                  ViewProduct(KJackets,_products),
                  ViewProduct(KJackets,_products)
                ],
              ),

            )
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

  Widget JecketView()
  {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
        builder: (context,snapshot){
        if(snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var _data = doc.data();
            products.add(Product(
              Pid: doc.id,
              pname: _data[KProductName],
              pprice: _data[KProductPrice],
              pdescription: _data[KProductDescription],
              pcategory: _data[KProductCaTegory],
              plocation: _data[KProductLocation],
            )
            );
          }
          _products=[...products];
          products.clear();
          return ViewProduct(KJackets,_products );
        }
        else
          {
            return Text("Loading");
          }
        },
    );
  }
}