import 'package:base_flutter_project/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'di/component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}
