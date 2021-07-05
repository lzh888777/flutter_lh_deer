import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/login/widgets/my_%20button.dart';
import 'package:flutter_lh_deer/res/dimens.dart';
import 'package:flutter_lh_deer/res/gaps.dart';
import 'package:flutter_lh_deer/res/styles.dart';
import 'package:flutter_lh_deer/routers/fluro_navigator.dart';
import 'package:flutter_lh_deer/store/store_router.dart';
import 'package:flutter_lh_deer/utils/theme_utils.dart';
import 'package:flutter_lh_deer/widegts/my_app_bar.dart';
import 'package:flutter_lh_deer/widegts/my_scroll_view.dart';
import 'package:flutter_lh_deer/widegts/selected_image.dart';
import 'package:flutter_lh_deer/widegts/selected_item.dart';
import 'package:flutter_lh_deer/widegts/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class StoreAuditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StoreAuditPageState();
  }
}

class _StoreAuditPageState extends State<StoreAuditPage> {
  final GlobalKey<SelectedImageState> _imageGlobalKey =
      GlobalKey<SelectedImageState>();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final ImagePicker picker = ImagePicker();
  String _address = '湖北省 武汉市 东西湖区 金银湖公园';
  String _sortName = '';
  final List<String> _list = [
    '水果生鲜',
    '家用电器',
    '休闲食品',
    '茶酒饮料',
    '美妆个护',
    '粮油调味',
    '家庭清洁',
    '厨具用品',
    '儿童玩具',
    '床上用品'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "店铺审核资料",
      ),
      body: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        keyboardConfig: _buildConfig(context),
        children: _buildBody(),
        tapOutsideToDismiss: true,
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () {
              NavigatorUtils.push(context, StoreRouter.auditResultPage);
            },
            text: "提交",
          ),
        ),
      ),
      resizeToAvoidBottomInset: defaultTargetPlatform != TargetPlatform.iOS,
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap5,
      const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text(
          "店铺资料",
          style: TextStyles.textBold18,
        ),
      ),
      Gaps.vGap16,
      Center(
        child: SelectedImage(
          key: _imageGlobalKey,
        ),
      ),
      Gaps.vGap10,
      Center(
        child: Text("店主手持身份证或营业执照",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: Dimens.font_sp14)),
      ),
      Gaps.vGap16,
      TextFieldItem(
        title: "店铺名称",
        hintText: "填写店铺名称",
        focusNode: _nodeText1,
      ),
      SelectedItem(
        title: "主营范围",
        content: _sortName,
        onTap: () => _showBottomSheet(),
      ),
      SelectedItem(
        title: "店铺地址",
        content: _address,
        onTap: () {
          // NavigatorUtils.pushResult(context, path, (p0) => null)
        },
      ),
      Gaps.vGap32,
      const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text("店主消息", style: TextStyles.textBold18),
      ),
      Gaps.hGap16,
      TextFieldItem(
        title: "店主姓名",
        focusNode: _nodeText2,
        hintText: "填写店主姓名",
      ),
      TextFieldItem(
        title: "联系电话",
        focusNode: _nodeText3,
        hintText: "填写店主联系电话",
        keyboardType: TextInputType.phone,
      ),
    ];
  }

  void _showBottomSheet() {}

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: _nodeText1, displayDoneButton: false),
          KeyboardActionsItem(focusNode: _nodeText2, displayDoneButton: false),
          KeyboardActionsItem(focusNode: _nodeText3, toolbarButtons: [
            (node) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text("关闭"),
                ),
              );
            }
          ]),
        ]);
  }
}
