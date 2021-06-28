import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lh_deer/res/gaps.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;

  const TextFieldItem(
      {Key? key,
      this.controller,
      required this.title,
      this.hintText = '',
      this.keyboardType = TextInputType.text,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Row child = Row(children: [
      Text(title),
      Gaps.hGap16,
      Expanded(
          child: Semantics(
        label: hintText.isEmpty ? '请输入$title' : hintText,
        child: TextField(
          focusNode: focusNode,
          keyboardType: keyboardType,
          inputFormatters: _getInputFormatters(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      )),
      Gaps.hGap16
    ]);

    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: Divider.createBorderSide(context, width: 0.6)),
      ),
      child: child,
    );
  }

  List<TextInputFormatter> _getInputFormatters() {
    if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    } else {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
  }
}
