import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lh_deer/login/login_router.dart';
import 'package:flutter_lh_deer/routers/fluro_navigator.dart';
import 'package:flutter_lh_deer/utils/imageUtils.dart';
import 'package:flutter_lh_deer/widegts/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSplash();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      // color: context.backgroundColor,
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    if (_status == 0) {
      return FractionallyAlignedSizedBox(
        heightFactor: 0.3,
        widthFactor: 0.33,
        leftFactor: 0.33,
        bottomFactor: 0,
        child: LoadAssetImage("logo"),
      );
    } else {
      return Swiper(
          itemCount: _guideList.length,
          loop: false,
          itemBuilder: (_, index) {
            return LoadAssetImage(
              _guideList[index],
              key: Key(_guideList[index]),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              format: ImageFormat.webp,
            );
          },
          onTap: (index) {
            if (index == _guideList.length - 1) {
              _goLogin();
            }
          });
    }
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _initGuide();
  }

  void _goLogin() {
    print("go login");
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);

    print("go login--");
  }
}
