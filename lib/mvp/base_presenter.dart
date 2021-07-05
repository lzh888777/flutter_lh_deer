import 'package:flutter_lh_deer/mvp/mvps.dart';

class BasePresenter<V extends IMvpView> extends IPresenter {
  late V View;
  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidgets<W>(W oldWidget) {}

  @override
  void dispose() {}

  @override
  void initState() {}
}
