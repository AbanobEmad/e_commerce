import 'package:ecommerce/Constains.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  static String id="Home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tabBarIndex=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  onTap: (value){
                    setState(() {
                      _tabBarIndex =value;
                    });
                    print("$_tabBarIndex beboooo");
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
            )
        )
      ],
    );
  }
}