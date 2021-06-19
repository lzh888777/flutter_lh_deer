import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/login/widgets/my_text_field.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/routers/fluro_navigator.dart';
import 'package:flutter_lh_deer/utils/change_notifier_manage.dart';
import 'package:flutter_lh_deer/widegts/my_app_bar.dart';
import 'package:flutter_lh_deer/widegts/my_scroll_view.dart';

import '../login_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
    with ChangeNotifierMixin<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  get NatigatorUtils => null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    _nameController.text = "15318761964";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          isBack: false,
          actionName: "Verrification Code login",
          onPressed: () =>
              NavigatorUtils.push(context, LoginRouter.smsLoginPage),
        ),
        body: MyScrollView(
            children: _buildBody,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0))
        // keyboardConfig: Util,),
        );
  }

  List<Widget> get _buildBody {
    return [
      const Text(
        "Password Login",
        style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
      ),
      Gaps.vGap16,
      MyTextField(
        controller: _nameController,
        key: const Key("phone"),
        focusNode: _nodeText1,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: "ppp",
      ),
      Gaps.vGap8,
      MyTextField(
        controller: _passwordController,
        key: const Key("password"),
        focusNode: _nodeText2,
        isInputPwd: true,
        maxLength: 11,
        keyboardType: TextInputType.visiblePassword,
        hintText: "sss",
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _login : null,
        key: const Key("login"),
        text: "login",
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: Text(
            "Forgot Password",
            key: const Key("forgotPassword"),
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onTap: () =>
              NatigatorUtils.push(context, LoginRouter.resetPasswordPage),
        ),
      ),
      Gaps.vGap16,
      Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text(
              "No account yet? Register now",
              key: const Key("noAccountRegister"),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
          ))
    ];
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _login() {}

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    } else if (password.isEmpty || password.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }
}
