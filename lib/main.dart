import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/home/splash_page.dart';
import 'package:flutter_lh_deer/routers/routers.dart';
import 'package:sp_util/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Widget? home;

  MyApp({Key? key, this.home}) : super(key: key) {
    Routes.initRoutes();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Deer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
