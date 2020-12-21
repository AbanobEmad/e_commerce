import 'package:ecommerce/CustomWidget/CustomTextField.dart';
import 'package:ecommerce/Provider/ModelHud.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Services/auth.dart';
import 'package:provider/provider.dart';
import '../../Constains.dart';
import '../../CustomWidget/Logo.dart';
class SignUp extends StatelessWidget {
  final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  final _auth=Auth();
  String Email,Password;
  static String id = "SignUp_Screen";
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
                    hint: "Enter Your Name",
                    icon: Icons.perm_identity
                ),
                SizedBox(
                  height: height*.02
                ),
                CustomTextField(
                  hint: "Enter Your E_mail",
                  icon: Icons.email,
                  OnClick: (value){
                    Email=value;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  hint: "Enter Your Password",
                  icon: Icons.lock,
                  OnClick:(value){
                    Password=value;
                  },),
                SizedBox(
                  height: height * .06,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder:(context)=> FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.black,
                        onPressed: () async
                        {
                          final _modelHud=Provider.of<ModelHud>(context,listen: false);
                          _modelHud.changeisLoadind(true);
                          if(_globalKey.currentState.validate())
                          {
                           _globalKey.currentState.save();
                           try {
                             final userCredential = await _auth.SignUP(
                                 Email, Password);
                             _modelHud.changeisLoadind(false);
                           }catch(e)
                          {
                            _modelHud.changeisLoadind(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  e.message
                                ),
                            ));
                          }
                          }
                          _modelHud.changeisLoadind(false);
                        },
                        child: Text(
                          "Sign Up",
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
                      'Do have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
