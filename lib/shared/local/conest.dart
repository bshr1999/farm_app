import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:man/model/test_model.dart';

String imagePath='https://walematk.com/';

String url='https://walematk.com/api/';

TestModel? testModel;


// ignore: non_constant_identifier_names
var clint_id;
String? phone;
bool isFirst=true;


Future<bool?> toast({
  required String text,
  required dynamic state,
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

// ignore: constant_identifier_names
enum ToastState{SUCCESS,ERROR,WARNING}

Color choseToastColor(ToastState state){
  Color color;
  switch (state){
    case ToastState.SUCCESS:
      color=Colors.green;
      break;
    case ToastState.ERROR:
      color=Colors.red;
      break;
    case ToastState.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}