import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/utils/theme_utils.dart';
import 'package:flutter_lh_deer/utils/toast_utils.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> launchWebURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('error url');
    }
  }

  static Future<void> launchTelURL(String phone) async {
    final String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('call failed');
    }
  }

  static String formatPrice(String price,
      {MoneyFormat format = MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(
        NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN,
        format: format);
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(
          list.length,
          (index) =>
              KeyboardActionsItem(focusNode: list[index], toolbarButtons: [
                (node) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text("Close"),
                    ),
                    onTap: () => node.unfocus(),
                  );
                }
              ])),
    );
  }
}
