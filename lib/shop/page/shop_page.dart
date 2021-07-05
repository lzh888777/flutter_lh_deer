import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/mvp/base_page.dart';
import 'package:flutter_lh_deer/mvp/mvps.dart';
import 'package:flutter_lh_deer/mvp/base_presenter.dart';
import 'package:flutter_lh_deer/shop/provider/user_provider.dart';

class ShopPage extends StatefulWidget {
  final bool isAccessibilityTest;

  const ShopPage({
    Key? key,
    this.isAccessibilityTest = false,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ShopPageState();
  }
}

class _ShopPageState extends State<ShopPage> with BasePageMixin {
  final List<String> _menuTitle = ['账户流水', '资金管理', '提现账号'];
  final List<String> _menuImage = ['zhls', 'zjgl', 'txzh'];
  final List<String> _menuDarkImage = ['dark_zhls', 'dark_zjgl', 'dark_txzh'];

  UserProvider provider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Text("Shop Page");
  }

  @override
  BasePresenter<IMvpView> createPresenter() {
    // TODO: implement createPresenter
    throw UnimplementedError();
  }
}
