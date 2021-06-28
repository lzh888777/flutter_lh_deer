import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/login/login_router.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/login/widgets/my_text_field.dart';
import 'package:flutter_lh_deer/res/dimens.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/res/styles.dart';
import 'package:flutter_lh_deer/routers/fluro_navigator.dart';
import 'package:flutter_lh_deer/utils/change_notifier_manage.dart';
import 'package:flutter_lh_deer/utils/other_utils.dart';
import 'package:flutter_lh_deer/utils/toast_utils.dart';
import 'package:flutter_lh_deer/widegts/my_app_bar.dart';
import 'package:flutter_lh_deer/widegts/my_scroll_view.dart';

class SMSLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SMSLoginPageState();
  }
}

class _SMSLoginPageState extends State<SMSLoginPage>
    with ChangeNotifierMixin<SMSLoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "SMS Login",
      ),
      body: MyScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        keyboardConfig: Utils.getKeyboardActionsConfig(
            context, <FocusNode>[_nodeText1, _nodeText2]),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      const Text(
        "Verification Code Login",
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        controller: _phoneController,
        focusNode: _nodeText1,
        keyboardType: TextInputType.phone,
        hintText: "Pelase input the Phone number",
        maxLength: 11,
      ),
      Gaps.vGap8,
      MyTextField(
        controller: _vCodeController,
        focusNode: _nodeText2,
        keyboardType: TextInputType.number,
        maxLength: 6,
        hintText: "Verification Code",
        getVCode: () {
          Toast.show("Verification Code has been sent");
          return Future<bool>.value(true);
        },
      ),
      Gaps.vGap8,
      Container(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
                text: "Unregistered phone number,please ",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: Dimens.font_sp14),
                children: <TextSpan>[
                  TextSpan(
                      text: "Register",
                      style: TextStyle(color: Theme.of(context).errorColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(
                              context, LoginRouter.registerPage);
                        }),
                  const TextSpan(text: ".")
                ]),
          )),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _login : null,
        text: "Login",
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: Text("Forgot Password",
              style: Theme.of(context).textTheme.subtitle2),
          onTap: () =>
              NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
        ),
      )
    ];
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _phoneController: callbacks,
      _vCodeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _phoneController.text;
    final String vCode = _vCodeController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {
    Toast.show('Logining......');
  }
}
