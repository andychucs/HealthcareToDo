
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hctodo/tippage/aid_page.dart';
import 'package:hctodo/tippage/care_page.dart';
import 'package:hctodo/tippage/mdc_page.dart';
import 'package:hctodo/tippage/tip_detail_page.dart';
import 'package:hctodo/toolpage/block_page.dart';
import 'package:hctodo/toolpage/cal_page.dart';

import 'model/hctd.dart';

Card makeCard(filename,type,BuildContext context) => Card(
  child: InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () {
      Navigator.of(context).push(CupertinoPageRoute(builder: (context){
        return TipDetailWidget(filename,type);
      }));
    },
    child: Container(
      width: 300,
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 8,
              child: Center(
                  child: Text(
                    filename.toString().substring(0,filename.toString().length - 3),
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(flex: 2, child: Icon(CupertinoIcons.forward))
        ],
      ),
    ),
  ),
);

CupertinoPageScaffold buildTipCupertinoPageScaffold(path,type,title) {
  return CupertinoPageScaffold(
    backgroundColor: Colors.grey[200],
    child: FutureBuilder(
      future: fetchPosy(path),
      builder: (context,snapshot){
        print('data:${snapshot.data}');
        print('connectionState:${snapshot.connectionState}');
        if(snapshot.hasData) {
          var fileJson = snapshot.data;
          final jsonMap = json.decode(fileJson);
          TipFiles files = TipFiles.fromJson(jsonMap);
          print(files.filename);
          return CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text(title),
                ),
                SliverSafeArea(
                  top: false,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
                          child: makeCard(files.filename[index],type,context),
                        );
                      },
                      childCount: files.filename.length,
                    ),
                  ),
                ),
              ],
            );
        } else if (snapshot.hasError){
          return Text(snapshot.error);
        }
        return Center(child: CupertinoActivityIndicator());
      },
    ),
  );
}
Card naviCard(item,BuildContext context) => Card(
  child: InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () {
      var target;
      switch (item){
        case '医保报销计算器':
          target = CalPage();
          break;
        case '时间块模式待办事项':
          target = BlockPage();
          break;
        case '护理小贴士':
          target = CarePage();
          break;
        case '急救知识':
          target = AidPage();
          break;
        case '常见药品':
          target = MdcPage();
          break;
        default:
          target = null;
      }
      Navigator.of(context).push(CupertinoPageRoute(builder: (context){
        return target;
      }));
    },
    child: Container(
      width: 300,
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 8,
              child: Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(flex: 2, child: Icon(CupertinoIcons.forward))
        ],
      ),
    ),
  ),
);


CupertinoPageScaffold buildTabPageScaffold(context,title,items) {
  return CupertinoPageScaffold(
    backgroundColor: Colors.grey[200],
    child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(title),
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 20,left: 20,top: 5),
                    child: naviCard(items[index], context),
                  );
                },
                childCount: items.length,
              )),
        )
      ],
    ),
  );
}
