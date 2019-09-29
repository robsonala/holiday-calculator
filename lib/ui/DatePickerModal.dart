import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerModal extends StatelessWidget {
  final Widget widget;
  final double _kPickerSheetHeight = 216.0;

  DatePickerModal({Key key, @required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: widget,
          ),
        ),
      ),
    );
  }
}
