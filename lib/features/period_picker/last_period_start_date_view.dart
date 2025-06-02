import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastPeriodStartDateView extends StatelessWidget {
  const LastPeriodStartDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Center(child: Text('My Last Period Started')),
      Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: CupertinoDatePicker(
            onDateTimeChanged: (DateTime newDateTime) {},
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime(2018, 9, 15),
            selectionOverlayBuilder: (
              BuildContext context, {
              required int selectedIndex,
              required int columnCount,
            }) {
              if (selectedIndex == 0) {
                return const CupertinoPickerDefaultSelectionOverlay(
                  capEndEdge: false,
                );
              } else if (selectedIndex == columnCount - 1) {
                return const CupertinoPickerDefaultSelectionOverlay(
                  capStartEdge: false,
                );
              }
              return const CupertinoPickerDefaultSelectionOverlay(
                capStartEdge: false,
                capEndEdge: false,
              );
            },
          ))
      // This is called wh
    ]));
  }
}
