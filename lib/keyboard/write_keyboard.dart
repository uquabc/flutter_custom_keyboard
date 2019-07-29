import 'package:flutter/material.dart';
import 'package:flutter_custom_keyboard/keyboard/keyboard.dart';

import 'keyboard_controller.dart';
import 'keyboard_manager.dart';

class WriteKeyboard extends StatefulWidget with Keyboard {
  _WriteKeyboardState _state;

  @override
  State<StatefulWidget> createState() {
    _state = _WriteKeyboardState();
    return _state;
  }

  static const CKTextInputType inputType = const CKTextInputType(name: 'WriteKeyboard');

  static double getHeight(BuildContext ctx) {
    return 200.0 + 50.0;
  }

  final KeyboardController controller;
  final KeyboardBarBuilder keyboardBarBuilder;

  WriteKeyboard({this.controller, this.keyboardBarBuilder});

  static register(KeyboardBarBuilder builder) {
    KeyboardManager.addKeyboard(
        WriteKeyboard.inputType,
        KeyboardConfig(
            builder: (context, controller) {
              return WriteKeyboard(
                controller: controller,
                keyboardBarBuilder: builder,
              );
            },
            getHeight: WriteKeyboard.getHeight));
  }

  @override
  void resetKeyboard() {
    _state?.resetKeyboard();
  }
}

class _WriteKeyboardState extends State<WriteKeyboard> {
  static const TYPE_NORMAL = 1;
  static const TYPE_NORMAL_UPPER = 2;
  static const TYPE_NUMBER = 3;
  static const TYPE_MORE = 4;
  var type = TYPE_NORMAL;
  var buttonWidth = 0.0;
  bool isExpandFooter = false;

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
              widget.keyboardBarBuilder.build(context, () {
                setState(() {
                  isExpandFooter = !isExpandFooter;
                });
              }, isExpandFooter),
              Expanded(
                child: IndexedStack(
                  index: isExpandFooter ? 1 : 0,
                  children: <Widget>[child, widget.keyboardBarBuilder.footWidget.build(context)],
                ),
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
          children: row1.map((e) => buildTextButton(isUpperCase ? e.toUpperCase() : e)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row2.map((e) => buildTextButton(isUpperCase ? e.toUpperCase() : e)).toList(),
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
            ..addAll(row3.map((e) => buildTextButton(isUpperCase ? e.toUpperCase() : e)).toList())
            ..add(buildDeleteButton()),
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
            buildNewlineButton()
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
              ..add(buildDeleteButton()),
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
              buildNewlineButton()
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
              ..add(buildDeleteButton()),
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
              buildNewlineButton()
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
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xFFDEDEDE)),
          child: Text(
            '空格',
            style: TextStyle(fontSize: 16),
          ),
        ),
        () => widget.controller.addText(" "));
  }

  Widget buildNewlineButton() {
    if (widget.controller.client.configuration.inputAction == TextInputAction.done) {
      return buildTextButton('完成', fontSize: 16, onTap: () {
        return widget.controller.doneAction();
      });
    } else {
      return buildTextButton('换行', fontSize: 16, onTap: () {
        return widget.controller.addText('\n');
      });
    }
  }

  Widget buildDeleteButton() {
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: buttonWidth, minHeight: 45, maxHeight: 45),
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            child: Center(
              child: Icon(Icons.backspace),
            ),
            onPanUpdate: (_) {
              widget.controller.deleteOne();
            },
          ),
        ));
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
        constraints: BoxConstraints(minWidth: buttonWidth, minHeight: 45, maxHeight: 45),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Center(
              child: widget,
            ),
            onTap: onTap,
          ),
        ));
  }

  void resetKeyboard() {
    setState(() {
      type = TYPE_NORMAL;
      isExpandFooter = false;
    });
  }
}

class KeyboardBarBuilder {
  final Builder footWidget;
  final PreferredSizeWidget Function(BuildContext context, Widget expandWidget) barBuilder;
  final Widget Function(bool isExpand) expandWidget;

  const KeyboardBarBuilder({this.barBuilder, this.expandWidget, this.footWidget});

  Widget build(context, onTap, isExpand) {
    return barBuilder(
        context,
        GestureDetector(
          child: expandWidget(isExpand),
          onTap: onTap,
        ));
  }
}
