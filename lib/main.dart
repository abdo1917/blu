// For performing some operations asynchronously
import 'package:blu/firebase_options.dart';
import 'package:blu/splash%20scree.dart';
import 'package:blu/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/controllers/device_controller.dart';
import 'app/controllers/global_controller.dart';
import 'app/views/main_view.dart';
import 'bluetooth_data.dart';
import 'homee.dart';

DateTime? currentBackPressTime;
late Controller ctrl;
late ScrollController listScrollController;
late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splash(),
    );
  }
}

