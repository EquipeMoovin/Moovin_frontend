import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/injection.dart' as di;
import 'app.dart';  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  

  await di.setup();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}
