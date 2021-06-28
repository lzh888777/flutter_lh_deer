import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/home/splash_page.dart';
import 'package:flutter_lh_deer/routers/routers.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
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
    // final Widget app = MultiProvider(
    //   providers: [

    //   ],
    //   child: Consumer2<ThemePro,
    // );
    final Widget app = MaterialApp(
      title: 'Flutter Deer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );

    return OKToast(
      child: app,
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
    );
  }
}
