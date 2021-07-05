import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends Dialog {
  final String hintText;

  const ProgressDialog({
    Key? key,
    this.hintText = '',
  }) : super(key: key);

  Widget build(BuildContext context) {
    final Widget progress = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Theme(
            data: ThemeData(
                cupertinoOverrideTheme: const CupertinoThemeData(
              brightness: Brightness.dark,
            )),
            child: const CupertinoActivityIndicator(
              radius: 14.0,
            )),
        SizedBox(height: 8.0),
        Text(
          hintText,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88.0,
          width: 120.0,
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              color: Color(0xFF3A3A3A)),
          child: progress,
        ),
      ),
    );
  }
}
