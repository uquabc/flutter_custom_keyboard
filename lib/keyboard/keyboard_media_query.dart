import 'package:flutter/material.dart';

import 'keyboard_manager.dart';

class KeyboardMediaQuery extends StatefulWidget {
  final Widget child;

  KeyboardMediaQuery({this.child}) : assert(child != null);

  @override
  State<StatefulWidget> createState() => KeyboardMediaQueryState();
}

class KeyboardMediaQueryState extends State<KeyboardMediaQuery> {
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return MediaQuery(
        child: widget.child,
        data: data.copyWith(
            viewInsets: data.viewInsets.copyWith(bottom: KeyboardManager.keyboardHeight)));
  }

  update() {
    setState(() => {});
  }
}
