import 'package:flutter/material.dart';

class MySelectDialogView {
  Function(void Function()) setState;
  BuildContext context; // ダイアログを呼び出したStateのcontext
  Map<String, String> selectMenu; // メニューの内容
  int selectValue; // 選択中の項目のインデックス
  Function(int?) onSelectChanged; // コールバック関数
  MySelectDialogView({required MySelectDialogWidget widget, required this.setState, required this.context, required this.selectMenu, required this.selectValue, required this.onSelectChanged}){
    width = widget.dialogWidth;
    maxHeight = widget.maxDialogHeight;
    itemHeight = widget.itemHeight;
  }

  double? width; // ダイアログ幅
  double? maxHeight; // ダイアログの高さ上限
  double? itemHeight; // メニューアイテムの高さ

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

    double height = itemHeight! * selectMenu.length;
    if (height > maxHeight!) {
      height = maxHeight!;
    }

    return SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
            controller: ScrollController(
                initialScrollOffset: itemHeight! * selectValue // 選択項目が見えるようにスクロールさせる
            ),
            child: Column(children: body)
        )
    );
  }
}

abstract class MySelectDialogWidget extends StatefulWidget {
  final double dialogWidth; // ダイアログ幅
  final double maxDialogHeight; // ダイアログの高さ上限
  final double itemHeight; // メニューアイテムの高さ
  const MySelectDialogWidget(this.dialogWidth, this.maxDialogHeight, this.itemHeight, {Key? key}) : super(key: key);
}
