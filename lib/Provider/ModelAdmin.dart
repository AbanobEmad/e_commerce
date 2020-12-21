import 'package:flutter/cupertino.dart';
class ModelAdmin extends ChangeNotifier {
  bool isAdmin = true;
  changeisAdmin(bool value){
    isAdmin=value;
    notifyListeners();
  }
}