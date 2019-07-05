import 'package:flutter/material.dart';

import 'keyboard/keyboard_manager.dart';
import 'keyboard/keyboard_media_query.dart';
import 'keyboard/write_keyboard.dart';

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
  Widget build(BuildContext context) {
    WriteKeyboard.register();
    return KeyboardMediaQuery(
      child: Builder(
        builder: (context) {
          CoolKeyboard.init(context);
          return Scaffold(
            body: Center(
              child: TextField(
//                keyboardType: TextInputType.multiline,
                keyboardType: WriteKeyboard.inputType,
                textInputAction: TextInputAction.newline,
                maxLines: null,
              ),
            ),
          );
        },
      ),
    );
  }
}

///不支持多行的原因：https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/plugin/editing/TextInputPlugin.java
