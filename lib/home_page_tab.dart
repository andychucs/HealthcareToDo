import 'package:flutter/cupertino.dart';
import 'package:event_tool/model/event.dart';
import 'package:event_tool/event_tool.dart';
import 'package:flutter/material.dart';
import 'package:hctodo/generated/i18n.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hctodo/model/hctd.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageTab createState() => HomePageTab();
}

class HomePageTab extends State<HomePage> {
  SlidableController slidableController;

  TextEditingController _textController;

  @protected
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
//    _textController = TextEditingController(text: );
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  CupertinoPageScaffold buildEditPageScaffold() {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey[200],
      navigationBar: CupertinoNavigationBar(
        middle: Text('编辑界面'),
      ),
      child: SafeArea(
        child: Center(
          child: Card(
            color: Colors.white,
            child: Container(
              height: 400,
              width: 300,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                  Container(
                    width: 200,
                    child: CupertinoTextField(
                      controller: _textController,
                      placeholder: '在这里输入一个事件',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('是否全天'),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoSwitch(
                          value: false,
                          onChanged: (flag) {
                            print(flag);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  CupertinoButton(
                    color: Colors.blueAccent,
                    child: Text('提交'),
                    onPressed: () => customEventName.add(_textController.text),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Event event = Event(
      title: 'An event',
      notes: 'from HealthcareToDo',
      location: 'your position',
      startDate: DateTime.now().add(Duration(minutes: 6)),
      endDate: DateTime.now().add(Duration(minutes: 7)),
      allDay: false,
      alarmBefore: 5,
    );

    event.title = eventName[0];
    final List<int> colorCodes = <int>[600, 500, 100];

    return CupertinoPageScaffold(
      backgroundColor: Colors.grey[200],
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(S.of(context).app_name),
            trailing: GestureDetector(
              onTap: () {
                print(event.startDate);
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  return buildEditPageScaffold();
                }));
              },
              child: Icon(CupertinoIcons.add),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () {},
          ),
          SliverSafeArea(
            top: false,
            bottom: false,
            sliver: SliverFixedExtentList(
              itemExtent: 60.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildSlidable(index, event, context);
                },
                childCount: customEventName.length,
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverFixedExtentList(
              itemExtent: 60.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
//                  var item = eventName[index];
                  return buildDefaultSlidable(index, context);
                },
                childCount: eventName.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Slidable buildSlidable(
      int index, Event event, BuildContext context) {
    final item = customEventName[index];
    return Slidable(
      key: ValueKey(item),
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: '耗时',
          color: Colors.greenAccent,
          icon: CupertinoIcons.time,
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    initialTimerDuration: Duration(minutes: 15),
                    onTimerDurationChanged: (time) {
                      event.endDate = event.startDate.add(time);
                    },
                  ),
                );
              }),
        ),
        IconSlideAction(
          caption: '开始时间',
          color: Colors.lightBlueAccent,
          icon: CupertinoIcons.clock,
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (time) {
                      event.startDate = time;
                    },
                  ),
                );
              }),
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: '创建',
            color: Colors.orangeAccent,
            icon: CupertinoIcons.create,
            onTap: () {
              event.title = item;
              event.alarmBefore = 5;
              customEventList.add(event);
              EventTool.addEvent(event).then((success) {
                showEventDialog(context, success);
              });
            }),
        IconSlideAction(
          caption: '删除',
          color: Colors.redAccent,
          icon: CupertinoIcons.delete,
        )
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType){
          setState(() {
            customEventName.removeAt(index);
          });
        },
      ),
      child: Column(
        children: <Widget>[
          Container(
              height: 59.0,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(''),
                  ),
                  Expanded(
                      flex: 8,
                      child: Center(child: Text('$item'))),
                  Expanded(
                    flex: 2,
                    child: Text(''),
                  ),
                ],
              )),
          Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Slidable buildDefaultSlidable(
      int index, BuildContext context) {
    final item = eventName[index];
    return Slidable(
      key: ValueKey(item),
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: '次数',
          color: Colors.amberAccent,
          icon: CupertinoIcons.refresh,
          onTap: () => true,
        ),
        IconSlideAction(
          caption: '开始时间',
          color: Colors.lightBlueAccent,
          icon: CupertinoIcons.clock,
          onTap: () => true,
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: '创建',
            color: Colors.orangeAccent,
            icon: CupertinoIcons.create,
            onTap: () {
              Event event = Event(
                title: getDefaultEvent()[index].name,
                notes: 'by HealthcareToDo',
                location: '',
                startDate: getDefaultEvent()[index].startTime,
                endDate: getDefaultEvent()[index].startTime.add(
                    Duration(minutes: getDefaultEvent()[index].timeConsuming)),
                allDay: false,
                alarmBefore: 1,
              );
              int count = getDefaultEvent()[index].count;
              int times = 0;
              int flag = 0;
              while (count > 0) {
                event.startDate = event.startDate.add(Duration(minutes: times));
                event.endDate = event.endDate.add(Duration(minutes: times));
                times += getDefaultEvent()[index].timeInterval;
                count--;
                EventTool.addEvent(event).then((success) {
                  flag++;
                  if (flag == 1) {
                    showEventDialog(context, success);
                  }
                });
              }

//              EventTool.addEvent(event).then((success) {showEventDialog(context, success);}
            }),
        IconSlideAction(
          caption: '删除',
          color: Colors.redAccent,
          icon: CupertinoIcons.delete,
        )
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType){
          setState(() {
            eventName.removeAt(index);
          });
        },
      ),
      child: Column(
        children: <Widget>[
          Container(
              height: 59.0,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(''),
                  ),
                  Expanded(
                      flex: 8,
                      child: Center(child: Text('$item'))),
                  Expanded(
                    flex: 2,
                    child: Text(''),
                  ),
                ],
              )),
          Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}

//class EventEditPage extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return buildEditPageScaffold();
//  }
//
//  CupertinoPageScaffold buildEditPageScaffold() {
//    return CupertinoPageScaffold(
//      navigationBar: CupertinoNavigationBar(
//        middle: Text('编辑界面'),
//      ),
//      child: SafeArea(
//        child: CupertinoTextField(
//          controller: _textController,
//          ),
//        ),
//      );
//  }
//}

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
