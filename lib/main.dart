import 'package:base_flutter_project/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'di/module.dart';

void main() async{

  await configureDependencies();
  runApp(MyApp());
}
