import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page_tab.dart';
import 'tips_page_tab.dart';

class MyApp extends StatelessWidget {
//  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark), title: Text('小贴士')),
        ],
      ),
      tabBuilder: (context,  index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePageTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TipsPageTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
