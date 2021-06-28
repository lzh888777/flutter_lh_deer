import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/login/widgets/my_text_field.dart';
import 'package:flutter_lh_deer/main.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/res/styles.dart';
import 'package:flutter_lh_deer/utils/change_notifier_manage.dart';
import 'package:flutter_lh_deer/utils/other_utils.dart';
import 'package:flutter_lh_deer/utils/toast_utils.dart';
import 'package:flutter_lh_deer/widegts/my_app_bar.dart';
import 'package:flutter_lh_deer/widegts/my_scroll_view.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage>
    with ChangeNotifierMixin<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _clickable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Register Account",
      ),
      body: MyScrollView(
        children: _buildBody(),
        keyboardConfig: Utils.getKeyboardActionsConfig(
            context, <FocusNode>[_nodeText1, _nodeText2, _nodeText3]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _vCodeController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
      _nodeText3: null,
    };
  }

  List<Widget> _buildBody() {
    return <Widget>[
      const Text(
        "Register Account",
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        controller: _nameController,
        key: const Key("phone"),
        focusNode: _nodeText1,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: "Please input the phone number",
      ),
      Gaps.vGap8,
      MyTextField(
        controller: _vCodeController,
        key: const Key("vcode"),
        focusNode: _nodeText2,
        maxLength: 6,
        keyboardType: TextInputType.number,
        hintText: "Verification Code",
        getVCode: () async {
          if (_nameController.text.length == 11) {
            Toast.show("verification code has been sent");
            return true;
          } else {
            Toast.show("Please input the right phone number");
            return false;
          }
        },
      ),
      Gaps.vGap8,
      MyTextField(
        controller: _passwordController,
        key: const Key("password"),
        focusNode: _nodeText3,
        isInputPwd: true,
        keyboardType: TextInputType.visiblePassword,
        maxLength: 16,
        hintText: "Please input the password",
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _register : null,
        text: "Register",
      )
    ];
  }

  void _register() {
    Toast.show('Register Done');
  }

  void _verify() {
    final String name = _nameController.text;
    final String vCode = _vCodeController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    } else if (vCode.isEmpty || vCode.length < 6) {
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
