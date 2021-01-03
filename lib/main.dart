import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/Provider/CartProduct.dart';
import 'package:ecommerce/Provider/ModelAdmin.dart';
import 'package:ecommerce/Provider/ModelHud.dart';
import 'package:ecommerce/Screens/admin/Add_Product.dart';
import 'package:ecommerce/Screens/admin/Edit_Product.dart';
import 'package:ecommerce/Screens/admin/Manage_product.dart';
import 'package:ecommerce/Screens/admin/HomeAdmin.dart';
import 'package:ecommerce/Screens/user/CartView.dart';
import 'package:ecommerce/Screens/user/Home.dart';
import 'package:ecommerce/Screens/user/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/user/Login_Screen.dart';
import 'Screens/user/SignUp_Screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  bool isUserLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder  <SharedPreferences>
      (
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot)
      {
        if(!snapshot.hasData)
          {
            return MaterialApp(home: Scaffold(body: Center(child: Text("Loading..........."),),));
          }
        else
          {
            isUserLoggedIn=snapshot.data.getBool(KKeepMeLoggedIn)??false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                    create: (context)=>ModelHud()),
                ChangeNotifierProvider<ModelAdmin>(
                    create: (context)=>ModelAdmin()),
                ChangeNotifierProvider<CartProduct>(
                    create: (context)=>CartProduct()),
              ],
              child: MaterialApp(
                initialRoute: isUserLoggedIn ? Home.id: LoginScreen.id,
                routes: {
                  CartView.id:(context)=>CartView(),
                  ProductInfo.id:(context)=>ProductInfo(),
                  LoginScreen.id : (context)=>LoginScreen(),
                  SignUp.id :(context)=>SignUp(),
                  HomeAdmin.id:(context)=>HomeAdmin(),
                  AddProduct.id:(context)=>AddProduct(),
                  ManagePeoduct.id:(context)=>ManagePeoduct(),
                  EtidProduct.id:(context)=>EtidProduct(),
                  Home.id:(context)=>Home(),
                },
              ),
            );
          }
      },
    );
  }
}
