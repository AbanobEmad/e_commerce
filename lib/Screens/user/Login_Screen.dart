import 'package:ecommerce/CustomWidget/CustomTextField.dart';
import 'package:ecommerce/Provider/ModelAdmin.dart';
import 'package:ecommerce/Provider/ModelHud.dart';
import 'package:ecommerce/Screens/user/Home.dart';
import 'package:ecommerce/Screens/admin/HomeAdmin.dart';
import 'package:ecommerce/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constains.dart';
import 'SignUp_Screen.dart';
import '../../CustomWidget/Logo.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Auth _auth = new Auth();

  String Email, Password;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool KeepMeLoggedin=false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: KConstColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoadind,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                Logo(),
                SizedBox(
                  height: height * .1,
                ),
                CustomTextField(
                  hint: "Enter Your E_mail",
                  icon: Icons.email,
                  OnClick: (value) {
                    Email = value;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  hint: "Enter Your Password",
                  icon: Icons.lock,
                  OnClick: (value) {
                    Password = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>
                    [
                      Text("Remmeber Me",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      Checkbox(
                        activeColor: KConstColor,
                          value: KeepMeLoggedin,
                          onChanged: (value)
                          {
                            setState(() {
                              KeepMeLoggedin=value;
                            });
                          }
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: height * .06,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder: (context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.black,
                        onPressed: ()  {
                          if(KeepMeLoggedin==true)
                            {
                              KeepUserLoggedIn();
                            }
                          _Validate(context);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: height * .06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dont\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                          Navigator.pushNamed(context, SignUp.id);
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Provider.of<ModelAdmin>(context, listen: false)
                              .changeisAdmin(true);
                        },
                        child: Text(
                          "I\ m Admin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<ModelAdmin>(context).isAdmin
                                  ?KConstColor:Colors.white),
                        ),
                      )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<ModelAdmin>(context, listen: false)
                                .changeisAdmin(false);
                          },
                          child: Text(
                            "I\ m User ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<ModelAdmin>(context).isAdmin
                                    ? Colors.white:KConstColor),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _Validate(BuildContext context) async {
    final _modelHud = Provider.of<ModelHud>(context,listen: false);
    _modelHud.changeisLoadind(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<ModelAdmin>(context, listen: false).isAdmin) {
        if (Password == "admin1234") {
          try {
            await _auth.SignIn(Email, Password);
            _modelHud.changeisLoadind(false);
            Navigator.pushNamed(context, HomeAdmin.id);
          } catch (e) {
            _modelHud.changeisLoadind(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          _modelHud.changeisLoadind(false);
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("The Password is not correct")));
        }
      } else {
        try {
          await _auth.SignIn(Email, Password);
          _modelHud.changeisLoadind(false);
          Navigator.pushNamed(context, Home.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    _modelHud.changeisLoadind(false);
  }

  void KeepUserLoggedIn() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool(KKeepMeLoggedIn, KeepMeLoggedin);
  }
}
