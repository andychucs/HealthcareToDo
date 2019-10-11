import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hctodo/tippage/aid_page_tab.dart';
import 'package:hctodo/tippage/mdc_page_tab.dart';
import 'home_page_tab.dart';
import 'tippage/tips_page_tab.dart';

class MyApp extends StatelessWidget {
//  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Color.fromARGB(150, 220, 220, 220),
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('待办')),
          BottomNavigationBarItem(
              icon: Icon(Icons.hotel), title: Text('护理')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), title: Text('急救')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text('药品')),
        ],
      ),
      tabBuilder: (context,  index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: HomePageTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: TipsPageTab(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: AidPageTab(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: MdcPageTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
