import 'package:flutter/material.dart';

import 'widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  // ポップアップメニュー1
  final Map<String, String> select1Menu = {
    '0': 'メニュー1',
    '1': 'メニュー2',
    '2': 'メニュー3',
    '3': 'メニュー4',
    '4': 'メニュー5',
    '5': 'メニュー6',
    '6': 'メニュー7',
    '7': 'メニュー8',
    '8': 'メニュー9',
    '9': 'メニュー10',
    '10': 'メニュー11',
    '11': 'メニュー12',
    '12': 'メニュー13',
    '13': 'メニュー14',
    '14': 'メニュー15',
    '15': 'メニュー16',
    '16': 'メニュー17',
    '17': 'メニュー18',
    '18': 'メニュー19',
    '19': 'メニュー20',
  };
  int select1Value = 0;
  void onSelect1Changed(int? value) {
    setState(() {
      select1Value = value!;
    });
  }

  // ポップアップメニュー2
  final Map<String, String> select2Menu = {
    '0': 'assets/icon1.png',
    '1': 'assets/icon4.png',
    '2': 'assets/icon5.png',
  };
  int select2Value = 0;
  void onSelect2Changed(int? value) {
    setState(() {
      select2Value = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    bool select1Test = true;
    bool select2Test = true;
    var body = <Widget>[];
    body.add(
        const SizedBox(height: 20)
    );

    if( select1Test ) {
      body.add(InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      insetPadding: EdgeInsets.all(0),
                      contentPadding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      content: MySelect1DialogWidget(this, contentWidth * 0.9, contentHeight * 0.9, 60.0)
                  );
                }
            );
          },
          child: Container(
              width: contentWidth * 0.7,
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 10.0, top: 0.0, right: 10.0, bottom: 0.0
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff000000))
              ),
              child: Text(select1Menu["$select1Value"]!)
          )
      ));
      body.add(
          const SizedBox(height: 20)
      );
    }

    if( select2Test ) {
      body.add(InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      insetPadding: EdgeInsets.all(0),
                      contentPadding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      content: MySelect2DialogWidget(this, contentWidth * 0.9, contentHeight * 0.9, 60.0)
                  );
                }
            );
          },
          child: Container(
              width: contentWidth * 0.7,
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 10.0, top: 0.0, right: 10.0, bottom: 0.0
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff000000))
              ),
              child: SizedBox(
                  width: 32,
                  height: 32,
                  child: Image.asset(
                      select2Menu['$select2Value']!, fit: BoxFit.fill)
              )
          )
      ));
    }

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 0
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body
        )
    );
  }
}

class MySelect1DialogWidget extends MySelectDialogWidget {
  final _MyHomePageState parent; // 親State
  const MySelect1DialogWidget(this.parent, double dialogWidth, double maxDialogHeight, double itemHeight, {Key? key}) : super(dialogWidth, maxDialogHeight, itemHeight, key: key);
  @override
  State createState() => MySelect1DialogState();
}
class MySelect1DialogState extends State<MySelect1DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final _MyHomePageState parent = widget.parent;
    return MySelectDialogView(
      widget: widget,
      setState: setState,
      context: parent.context, // 親Stateのcontextを渡す
      selectMenu: parent.select1Menu, // 親Stateで宣言された変数
      selectValue: parent.select1Value, // 親Stateで宣言された変数
      onSelectChanged: parent.onSelect1Changed, // 親Stateで宣言された関数
    ).build();
  }
}

class MySelect2DialogWidget extends MySelectDialogWidget {
  final _MyHomePageState parent; // 親State
  const MySelect2DialogWidget(this.parent, double dialogWidth, double maxDialogHeight, double itemHeight, {Key? key}) : super(dialogWidth, maxDialogHeight, itemHeight, key: key);
  @override
  State createState() => MySelect2DialogState();
}
class MySelect2DialogState extends State<MySelect2DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final _MyHomePageState parent = widget.parent;
    return MySelectDialogView(
      widget: widget,
      setState: setState,
      context: parent.context, // 親Stateのcontextを渡す
      selectMenu: parent.select2Menu, // 親Stateで宣言された変数
      selectValue: parent.select2Value, // 親Stateで宣言された変数
      onSelectChanged: parent.onSelect2Changed, // 親Stateで宣言された関数
    ).build();
  }
}
