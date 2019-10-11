import 'package:flutter/cupertino.dart';
import 'package:event_tool/model/event.dart';
import 'package:event_tool/event_tool.dart';
import 'package:flutter/material.dart';
import 'package:hctodo/generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:ui' as ui;

List<String> eventName = <String>['事件一', '事件二', '事件三', '事件四', '事件五'];

class HomePageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Event event = Event(
      title: 'An event',
      notes: 'from Even Tool',
      location: 'your position',
      startDate: DateTime.now().add(Duration(minutes: 6)),
      endDate: DateTime.now().add(Duration(minutes: 7)),
      allDay: false,
      alarmBefore: 5,
    );

    event.title = 'TEST';
    final List<int> colorCodes = <int>[600, 500, 100];

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(150, 220, 220, 220),
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(S.of(context).app_name),
            trailing: GestureDetector(
              onTap: () {
                eventName.add('测试事件');
                CupertinoSliverRefreshControl();
              },
              child: Icon(CupertinoIcons.add),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: (){},
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildSlidable(index, event, context);
                },
                childCount: eventName.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Slidable buildSlidable(int index, Event event, BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: '耗时',
          color: Colors.greenAccent,
          icon: CupertinoIcons.time,
          onTap: () => true,
        ),
        IconSlideAction(
          caption: '开始时间',
          color: Colors.lightBlue,
          icon: CupertinoIcons.clock,
          onTap: () => true,
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: '创建',
            color: Colors.orangeAccent,
            icon: CupertinoIcons.create,
            onTap: () => EventTool.addEvent(event).then((success) {
                  showEventDialog(context, success);
                })),
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: CupertinoIcons.delete,
        )
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
      ),
      child: Container(
          color: Colors.lightBlue[100 * (index % 9)],
          child: Center(child: Text('${eventName[index]}'))),
    );
  }
}

void showEventDialog(BuildContext context, bool returnStatus) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('Test event'),
        content: Text(returnStatus ? 'Success' : 'Error'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
