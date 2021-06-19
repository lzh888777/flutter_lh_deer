import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/res/colors.dart';
import 'package:flutter_lh_deer/res/dimens.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/utils/theme_utils.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Color? backImgColor;
  final String actionName;
  final VoidCallback? onPressed;
  final bool isBack;

  const MyAppBar(
      {Key? key,
      this.backgroundColor,
      this.title = "",
      this.centerTitle = "",
      this.backImg = "assets/images/ic_back_black.png",
      this.backImgColor,
      this.actionName = "",
      this.onPressed,
      this.isBack = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Color curBackgroundColor = backgroundColor ?? context.backgroundColor;
    final SystemUiOverlayStyle cur_overlayStyle =
        ThemeData.estimateBrightnessForColor(curBackgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final isBack = await Navigator.maybePop(context);
              if (!isBack) {
                await SystemNavigator.pop();
              }
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: Image.asset(backImg,
                color: backImgColor ?? ThemeUtils.getIconColor(context)),
          )
        : Gaps.empty;

    final Widget action = actionName.isNotEmpty
        ? Container(
            alignment: Alignment.center,
            child: Theme(
                data: Theme.of(context).copyWith(
                    buttonTheme: const ButtonThemeData(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        minWidth: 60.0)),
                child: MyButton(
                  key: const Key("actionName"),
                  fontSize: Dimens.font_sp14,
                  minWidth: null,
                  text: actionName,
                  textColor: context.isDark ? Colours.dark_text : Colours.text,
                  backgroundColor: Colors.transparent,
                  onPressed: onPressed,
                )),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: const TextStyle(fontSize: Dimens.font_sp18),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48),
      ),
    );

    return AnnotatedRegion(
        child: Material(
          color: curBackgroundColor,
          child: SafeArea(
              child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              titleWidget,
              back,
              action,
            ],
          )),
        ),
        value: cur_overlayStyle);
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
