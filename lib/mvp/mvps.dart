import 'package:flutter/material.dart';

import 'i_lifecycle.dart';

abstract class IMvpView {
  BuildContext getContext();

  void showProgress();
  void closeProgress();
  void showToast(String msg);
}

abstract class IPresenter extends ILifecycle {}
