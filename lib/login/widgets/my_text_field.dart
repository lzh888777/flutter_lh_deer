import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/res/colors.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/utils/device.dart';
import 'package:flutter_lh_deer/widegts/load_image.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode? focusNode;
  final bool isInputPwd;
  final Future<bool> Function()? getVCode;

  /// 用于集成测试寻找widget
  final String? keyName;

  const MyTextField(
      {Key? key,
      required this.controller,
      this.maxLength = 16,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.focusNode,
      this.isInputPwd = false,
      this.getVCode,
      this.keyName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyTextFieldState();
  }
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  late int _currentSecond;
  StreamSubscription? _subscription;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;

    Widget textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      inputFormatters: _myTextFieldInputFormatter,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        counterText: "",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: themeData.primaryColor, width: 0.8),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colours.bg_gray, width: 0.8)),
      ),
    );

    if (Device.isAndroid) {
      textField = Listener(
          onPointerDown: (e) =>
              FocusScope.of(context).requestFocus(widget.focusNode),
          child: textField);
    }
    Widget? clearButton;

    if (_isShowDelete) {
      clearButton = Semantics(
        label: "清空",
        hint: "清空输入框",
        child: GestureDetector(
          child: LoadAssetImage(
            "login/qyg_show_icon_delete",
            key: Key('${widget.keyName}_delete'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () => widget.controller.text = "",
        ),
      );
    }
    late Widget pwdVisible;
    if (widget.isInputPwd) {
      pwdVisible = Semantics(
        label: "密码可见开关",
        hint: "密码是否可见",
        child: GestureDetector(
          child: LoadAssetImage(
            _isShowPwd
                ? 'login/qyg_shop_icon_display'
                : 'login/qyg_shop_icon_hide',
            width: 18.0,
            height: 40.0,
          ),
          onTap: () {
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      );
    }
    late Widget getVCodeButton;
    if (widget.getVCode != null) {
      getVCodeButton = MyButton(
        onPressed: _clickable ? _getVCode : null,
        key: const Key("getVerificationCode"),
        fontSize: 12.0,
        text: _clickable ? "send vc code" : '（$_currentSecond s)',
        textColor: themeData.primaryColor,
        disabledTextColor: Colors.transparent,
        disabledBackgroundColor:
            isDark ? Colours.dark_text_gray : Colours.text_gray_c,
        radius: 1.0,
        minHeight: 26.0,
        minWidth: 76.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        side: BorderSide(
          color: _clickable ? themeData.primaryColor : Colors.transparent,
          width: 0.8,
        ),
      );
    }
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              child: clearButton ?? Gaps.empty,
              visible: _isShowDelete,
            ),
            if (widget.isInputPwd) Gaps.hGap15,
            if (widget.isInputPwd) pwdVisible,
            if (widget.getVCode != null) Gaps.hGap15,
            if (widget.getVCode != null) getVCodeButton,
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  void isEmpty() {
    final bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  void _getVCode() {}

  List<TextInputFormatter> get _myTextFieldInputFormatter {
    if (widget.keyboardType == TextInputType.number ||
        widget.keyboardType == TextInputType.phone) {
      return [FilteringTextInputFormatter.allow(RegExp('[0-9]'))];
    } else {
      return [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))];
    }
  }
}
