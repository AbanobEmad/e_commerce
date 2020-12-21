import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool isLoadind = false;
  changeisLoadind(bool value){
    isLoadind=value;
    notifyListeners();
  }
}