import 'package:flutter/material.dart';
import 'package:flutter_custom_keyboard/keyboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //1.KeyboardMediaQuery计算屏幕高度
    return KeyboardMediaQuery(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                //点击其他地方隐藏键盘
                KeyboardManager.hideKeyboard();
              },
              child: MyTextField(),
            ),
          );
        },
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  void initState() {
    super.initState();
    //2.注册键盘
    WriteKeyboard.register(_getBarBuilder());
    //3.初始化键盘
    KeyboardManager.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardManager.dispose();
  }

  KeyboardBarBuilder _getBarBuilder() {
    return KeyboardBarBuilder(
        barBuilder: (context, expandWidget) {
          return PreferredSize(
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey,
              child: Row(children: [
                Expanded(child: _alternativeBtn('AAA')),
                Expanded(child: _alternativeBtn('BBB')),
                Expanded(child: _alternativeBtn('CCC')),
                expandWidget
              ]),
            ),
            preferredSize: Size.fromHeight(50),
          );
        },
        footWidget: Builder(
          builder: (context) => GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                children: [
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                  _alternativeBtn('QQQ'),
                ],
              ),
        ),
        expandWidget: (isExpand) => Padding(
              child: Icon(
                isExpand ? Icons.arrow_upward : Icons.arrow_downward,
                size: 26,
              ),
              padding: EdgeInsets.only(right: 15),
            ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //5.更新
    KeyboardManager.refreshAncestor(context);
  }

  Widget _alternativeBtn(String text) {
    return InkWell(
      child: Text(text),
      onTap: () {
        KeyboardManager.addText(text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(hintText: '请输入内容'),
          //4.使用自定义键盘
          keyboardType: WriteKeyboard.inputType,
          textInputAction: TextInputAction.newline,
          maxLines: null,
        ),
        ElevatedButton(
          child: Text('reset keyboard'),
          onPressed: () {
            KeyboardManager.resetKeyboard();
          },
        )
      ],
    );
  }
}
