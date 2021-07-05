import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/goods/page/goods_page.dart';
import 'package:flutter_lh_deer/home/provider/home_provider.dart';
import 'package:flutter_lh_deer/order/order_page.dart';
import 'package:flutter_lh_deer/res/resources.dart';
import 'package:flutter_lh_deer/shop/page/shop_page.dart';
import 'package:flutter_lh_deer/statistics/page/statistics_page.dart';
import 'package:flutter_lh_deer/widegts/double_tap_back_exit_app.dart';
import 'package:flutter_lh_deer/widegts/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with RestorationMixin {
  static const double _imageSize = 25.0;
  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = false; //context.isDark;
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __) {
              return BottomNavigationBar(
                items: isDark
                    ? _buildDarkBottomNavigationBarItem()
                    : _buildBottomNavigationBarItem(),
                // backgroundColor: context.,
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: 10.0,
                unselectedFontSize: 10.0,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark
                    ? Colours.dark_unselected_item_color
                    : Colours.unselected_item_color,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index) => provider.value = index,
            children: _pageList,
          ),
        ),
      ),
    );
  }

  void initData() {
    _pageList = [OrderPage(), GoodsPage(), StatisticsPage(), ShopPage()];
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }

  _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const _tabImageDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize),
          LoadAssetImage('home/icon_order',
              width: _imageSize, color: Colours.dark_app_main)
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.dark_app_main,
          )
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.dark_app_main,
          )
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ]
      ];

      _listDark = List.generate(_tabImageDark.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImageDark[i][0],
          activeIcon: _tabImageDark[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ]
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }
}
