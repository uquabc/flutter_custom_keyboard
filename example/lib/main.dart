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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WriteKeyboard.register(keyboardBarBuilder);
  }

  var keyboardBarBuilder = KeyboardBarBuilder(
      barBuilder: (context, expandWidget) {
        return PreferredSize(
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.red,
            child: Row(children: [
              Expanded(child: Text('AAA')),
              Expanded(child: Text('BBB')),
              Expanded(child: Text('CCC')),
              expandWidget
            ]),
          ),
          preferredSize: Size.fromHeight(50),
        );
      },
      footWidget: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        children: [
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
          Text('QQQ'),
        ],
      ),
      expandWidget: (isExpand) => Padding(
            child: Icon(
              isExpand ? Icons.arrow_upward : Icons.arrow_downward,
              size: 26,
            ),
            padding: EdgeInsets.only(right: 15),
          ));

  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(
      child: Builder(
        builder: (context) {
          CoolKeyboard.init(context);
          return Scaffold(
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                CoolKeyboard.hideKeyboard();
              },
              child: Center(
                child: TextField(
                  keyboardType: WriteKeyboard.inputType,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
