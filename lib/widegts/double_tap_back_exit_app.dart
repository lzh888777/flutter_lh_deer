import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleTapBackExitApp extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const DoubleTapBackExitApp(
      {Key? key,
      this.duration = const Duration(milliseconds: 2500),
      required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DoubleTapBackExitAppState();
  }
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: widget.child, onWillPop: _isExit);
  }

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      // Toast.show('再次点击退出应用');
      return Future.value(false);
    }
    // Toast.cancelToast();
    await SystemNavigator.pop();
    return Future.value(true);
  }
}
