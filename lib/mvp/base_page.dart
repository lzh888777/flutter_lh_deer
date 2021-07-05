import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/mvp/base_presenter.dart';
import 'package:flutter_lh_deer/mvp/mvps.dart';
import 'package:flutter_lh_deer/routers/fluro_navigator.dart';
import 'package:flutter_lh_deer/widegts/progress_dialog.dart';

mixin BasePageMixin<T extends StatefulWidget, P extends BasePresenter>
    on State<T> implements IMvpView {
  P? presenter;
  P createPresenter();
  bool _isShowDialog = false;

  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      // NavigatorUtils.goBack(context);
    }
  }

  @override
  void showProgress() {
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog(
          context: context,
          builder: (_) {
            return WillPopScope(
                child: buildProgress(),
                onWillPop: () async {
                  _isShowDialog = false;
                  return Future.value(true);
                });
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void showToast(String msg) {
    // Toast.show(string);
  }

  Widget buildProgress() => ProgressDialog(hintText: '正在加载...');
}
