import 'package:flutter/material.dart';

import 'keyboard_controller.dart';
import 'keyboard_manager.dart';

class WriteKeyboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WriteKeyboardState();
  }

  static const CKTextInputType inputType =
      const CKTextInputType(name: 'WriteKeyboard');

  static double getHeight(BuildContext ctx) {
//    MediaQueryData mediaQuery = MediaQuery.of(ctx);
//    return mediaQuery.size.width / 3 / 2 * 4;
    return 200.0 + 50.0;
  }

  final KeyboardController controller;

  const WriteKeyboard({this.controller});

  static register() {
    CoolKeyboard.addKeyboard(
        WriteKeyboard.inputType,
        KeyboardConfig(
            builder: (context, controller) {
              return WriteKeyboard(controller: controller);
            },
            getHeight: WriteKeyboard.getHeight));
  }
}

class _WriteKeyboardState extends State<WriteKeyboard> {
  static const TYPE_NORMAL = 1;
  static const TYPE_NORMAL_UPPER = 2;
  static const TYPE_NUMBER = 3;
  static const TYPE_MORE = 4;
  var type = TYPE_NORMAL;
  var buttonWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    buttonWidth = mediaQuery.size.width / 11;
    Widget child;
    switch (type) {
      case TYPE_NORMAL:
        child = buildNormalKeyboard(false);
        break;
      case TYPE_NORMAL_UPPER:
        child = buildNormalKeyboard(true);
        break;
      case TYPE_NUMBER:
        child = buildNumberKeyboard();
        break;
      case TYPE_MORE:
        child = buildMoreKeyboard();
        break;
    }
    return Material(
      child: Container(
          height: WriteKeyboard.getHeight(context),
          width: mediaQuery.size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                width: double.infinity,
                height: 50,
                child: Text('这是我要自定义的内容啊'),
              ),
              Expanded(
                child: child,
              )
            ],
          )),
    );
  }

  Widget buildNormalKeyboard(bool isUpperCase) {
    final row1 = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
    final row2 = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
    final row3 = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: row1
              .map((e) => buildTextButton(isUpperCase ? e.toUpperCase() : e))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row2
              .map((e) => buildTextButton(isUpperCase ? e.toUpperCase() : e))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(Icon(Icons.arrow_upward), () {
              setState(() {
                if (type == TYPE_NORMAL) {
                  type = TYPE_NORMAL_UPPER;
                } else {
                  type = TYPE_NORMAL;
                }
              });
            })
          ]
            ..addAll(row3
                .map((e) => buildTextButton(isUpperCase ? e.toUpperCase() : e))
                .toList())
            ..add(buildButton(
                Icon(Icons.backspace), () => widget.controller.deleteOne())),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildTextButton('?123', fontSize: 16, onTap: () {
              setState(() {
                type = TYPE_NUMBER;
              });
            }),
            buildTextButton('\''),
            buildTextButton('...'),
            buildSpaceButton(),
            buildTextButton('-'),
            buildTextButton('.'),
            buildTextButton('换行',
                fontSize: 16, onTap: () => widget.controller.newLineAction())
          ],
        )
      ],
    );
  }

  Widget buildNumberKeyboard() {
    final row1 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
    final row2 = [',', '!', '?', '(', ')', '&', '/', '|', '||'];
    final row3 = [':', '"', '.', '@', '%', '℃', 'é'];

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: row1.map((e) => buildTextButton(e)).toList(),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row2.map((e) => buildTextButton(e)).toList(),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTextButton('更多', fontSize: 16, onTap: () {
                setState(() {
                  type = TYPE_MORE;
                });
              })
            ]
              ..addAll(row3.map((e) => buildTextButton(e)).toList())
              ..add(buildButton(
                  Icon(Icons.backspace), () => widget.controller.deleteOne())),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildTextButton('ABC', fontSize: 16, onTap: () {
                setState(() {
                  type = TYPE_NORMAL;
                });
              }),
              buildTextButton('\''),
              buildTextButton('...'),
              buildSpaceButton(),
              buildTextButton('-'),
              buildTextButton('.'),
              buildTextButton('换行',
                  fontSize: 16, onTap: () => widget.controller.newLineAction())
            ],
          ),
        )
      ],
    );
  }

  Widget buildMoreKeyboard() {
    final row1 = ['[', ']', '{', '}', '<', '>', '《', '》', '「」', ';'];
    final row2 = ['+', '-', '=', '*', '~', '^', '_', '|', '\\'];
    final row3 = ['#', '≠', '\$', '￥', '£', '€', '₣'];

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: row1.map((e) => buildTextButton(e)).toList(),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row2.map((e) => buildTextButton(e)).toList(),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTextButton('?123', fontSize: 16, onTap: () {
                setState(() {
                  type = TYPE_NUMBER;
                });
              })
            ]
              ..addAll(row3.map((e) => buildTextButton(e)).toList())
              ..add(buildButton(
                  Icon(Icons.backspace), () => widget.controller.deleteOne())),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildTextButton('ABC', fontSize: 16, onTap: () {
                setState(() {
                  type = TYPE_NORMAL;
                });
              }),
              buildTextButton('\''),
              buildTextButton('...'),
              buildSpaceButton(),
              buildTextButton('-'),
              buildTextButton('.'),
              buildTextButton('换行',
                  fontSize: 16, onTap: () => widget.controller.newLineAction())
            ],
          ),
        )
      ],
    );
  }

  Widget buildSpaceButton() {
    return buildButton(
        Container(
          width: 100,
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey),
          child: Text(
            '空格',
            style: TextStyle(fontSize: 16),
          ),
        ),
        () => widget.controller.addText(" "));
  }

  Widget buildTextButton(
    String title, {
    double fontSize = 22,
    String value,
    GestureTapCallback onTap,
  }) {
    if (value == null) {
      value = title;
    }

    return buildButton(
        Text(
          title,
          style: TextStyle(fontSize: fontSize),
        ),
        onTap ?? () => widget.controller.addText(value));
  }

  Widget buildButton(Widget widget, GestureTapCallback onTap) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: buttonWidth, minHeight: 45, maxHeight: 45),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: widget,
          ),
          onTap: onTap,
        ));
  }
}
