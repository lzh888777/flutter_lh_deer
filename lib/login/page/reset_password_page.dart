import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/login/widgets/my_text_field.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/res/styles.dart';
import 'package:flutter_lh_deer/utils/change_notifier_manage.dart';
import 'package:flutter_lh_deer/utils/other_utils.dart';
import 'package:flutter_lh_deer/utils/toast_utils.dart';
import 'package:flutter_lh_deer/widegts/my_app_bar.dart';
import 'package:flutter_lh_deer/widegts/my_scroll_view.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with ChangeNotifierMixin<ResetPasswordPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _clickable = false;

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

  void _reset() {
    Toast.show("已修改");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Forget Password",
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(
            context, [_nodeText1, _nodeText2, _nodeText3]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      const Text("Reset Password", style: TextStyles.textBold26),
      Gaps.vGap16,
      MyTextField(
        controller: _nameController,
        focusNode: _nodeText1,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: "Please input the number",
      ),
      Gaps.vGap8,
      MyTextField(
        controller: _vCodeController,
        focusNode: _nodeText2,
        keyboardType: TextInputType.number,
        getVCode: () => Future<bool>.value(true),
        maxLength: 6,
        hintText: "Verification Code",
      ),
      Gaps.vGap8,
      MyTextField(
        controller: _passwordController,
        focusNode: _nodeText3,
        keyboardType: TextInputType.visiblePassword,
        maxLength: 16,
        isInputPwd: true,
        hintText: "Password",
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _reset : null,
        text: "Confirm",
      )
    ];
  }
}
