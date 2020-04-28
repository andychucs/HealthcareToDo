import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hctodo/hospital_page_tab.dart';
import 'package:hctodo/tippage/tip_page_tab.dart';
import 'package:hctodo/toolpage/tool_page_tab.dart';
import 'home_page_tab.dart';

class MyApp extends StatelessWidget {
//  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('待办')),
          BottomNavigationBarItem(
              icon: Icon(Icons.build,size: 25,), title: Text('工具')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), title: Text('医院')),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder), title: Text('资料库')),
        ],
      ),
      tabBuilder: (context,  index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: HomePage(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: ToolPageTab(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: HospitalPageTab(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                backgroundColor: Color.fromARGB(150, 220, 220, 220),
                child: TipPageTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
