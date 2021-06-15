import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class MyScrollView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? bottomButton;
  final KeyboardActionsConfig? keyboardConfig;

  /// 键盘外部按下将其关闭
  final bool tapOutsideToDismiss;

  /// 默认弹起位置在TextField的文字下面，可以添加此属性继续向上滑动一段距离。用来露出完整的TextField。
  final double overScroll;

  const MyScrollView(
      {Key? key,
      this.padding,
      this.physics = const BouncingScrollPhysics(),
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.bottomButton,
      this.keyboardConfig,
      this.tapOutsideToDismiss = false,
      this.overScroll = 16.0,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contents = Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    if (defaultTargetPlatform == TargetPlatform.iOS && keyboardConfig != null) {
      if (padding != null) {
        contents = Padding(
          padding: padding!,
          child: contents,
        );
      }

      contents = KeyboardActions(
        config: keyboardConfig!,
        isDialog: bottomButton != null,
        overscroll: overScroll,
        tapOutsideToDismiss: tapOutsideToDismiss,
        child: contents,
      );
    } else {
      contents = SingleChildScrollView(
        padding: padding,
        physics: physics,
        child: contents,
      );
    }

    if (bottomButton != null) {
      contents = Column(
        children: [Expanded(child: contents), SafeArea(child: bottomButton!)],
      );
    }
    return contents;
  }
}
