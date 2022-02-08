import 'package:flutter/material.dart';

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

class MySelectDialogView {
  Function(void Function()) setState;
  BuildContext context; // ダイアログを呼び出したStateのcontext
  double width; // ダイアログ幅
  double maxHeight; // ダイアログの高さ上限
  double itemHeight; // メニューアイテムの高さ
  Map<String, String> selectMenu; // メニューの内容
  int selectValue; // 選択中の項目のインデックス
  Function(int?) onSelectChanged; // コールバック関数
  MySelectDialogView({required this.setState, required this.context, required this.width, required this.maxHeight, required this.itemHeight, required this.selectMenu, required this.selectValue, required this.onSelectChanged});

  Widget title(int i){
    String itemString = selectMenu['$i']!;
    if( itemString.startsWith('assets/') ){
      return Row(children: [ SizedBox(
          width: 32,
          height: 32,
          child: Image.asset(selectMenu['$i']!, fit: BoxFit.fill)
      ) ] );
    }
    return Text(itemString);
  }

  Widget build() {
    var body = <Widget>[];
    for (int i = 0; i < selectMenu.length; i++) {
      body.add(Container(
          height: itemHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))
          ),
          child: RadioListTile(
              title: title(i),
              value: i,
              groupValue: selectValue,
              controlAffinity: ListTileControlAffinity.trailing, // ラベルを左側に
              toggleable: true, // 選択中の項目をタップしてもonChangedが呼ばれるようにする
              onChanged: (int? value) {
                // 選択中の項目がタップされた場合、valueはnullになる
                if (value != null) {
                  setState(() {
                    selectValue = value;
                  });
                  onSelectChanged(value);
                }
                Navigator.pop(context); // ダイアログを閉じる
              }
          )
      ));
    }

    double height = itemHeight * selectMenu.length;
    if (height > maxHeight) {
      height = maxHeight;
    }

    return SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
            controller: ScrollController(
                initialScrollOffset: itemHeight * selectValue // 選択項目が見えるようにスクロールさせる
            ),
            child: Column(children: body)
        )
    );
  }
}

class MySelect1DialogWidget extends StatefulWidget {
  final _MyHomePageState parent; // 親State
  final double dialogWidth; // ダイアログ幅
  final double maxDialogHeight; // ダイアログの高さ上限
  final double itemHeight; // メニューアイテムの高さ
  const MySelect1DialogWidget(this.parent, this.dialogWidth, this.maxDialogHeight, this.itemHeight, {Key? key}) : super(key: key);

  @override
  State createState() => MySelect1DialogState();
}
class MySelect1DialogState extends State<MySelect1DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final _MyHomePageState parent = widget.parent;
    return MySelectDialogView(
      setState: setState,
      context: parent.context, // 親Stateのcontextを渡す
      width: widget.dialogWidth,
      maxHeight: widget.maxDialogHeight,
      itemHeight: widget.itemHeight,
      selectMenu: parent.select1Menu, // 親Stateで宣言された変数
      selectValue: parent.select1Value, // 親Stateで宣言された変数
      onSelectChanged: parent.onSelect1Changed, // 親Stateで宣言された関数
    ).build();
  }
}

class MySelect2DialogWidget extends StatefulWidget {
  final _MyHomePageState parent; // 親State
  final double dialogWidth; // ダイアログ幅
  final double maxDialogHeight; // ダイアログの高さ上限
  final double itemHeight; // メニューアイテムの高さ
  const MySelect2DialogWidget(this.parent, this.dialogWidth, this.maxDialogHeight, this.itemHeight, {Key? key}) : super(key: key);

  @override
  State createState() => MySelect2DialogState();
}
class MySelect2DialogState extends State<MySelect2DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final _MyHomePageState parent = widget.parent;
    return MySelectDialogView(
      setState: setState,
      context: parent.context, // 親Stateのcontextを渡す
      width: widget.dialogWidth,
      maxHeight: widget.maxDialogHeight,
      itemHeight: widget.itemHeight,
      selectMenu: parent.select2Menu, // 親Stateで宣言された変数
      selectValue: parent.select2Value, // 親Stateで宣言された変数
      onSelectChanged: parent.onSelect2Changed, // 親Stateで宣言された関数
    ).build();
  }
}
