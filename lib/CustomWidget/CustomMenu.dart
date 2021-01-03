
import 'package:flutter/material.dart';

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
class MyPopupMuneItemState<T,PopupMenuItem> extends PopupMenuItemState<T,MyPopupMenuItem<T>> {

  @override
  void handleTap() {
    widget.Onclick();
  }
}
