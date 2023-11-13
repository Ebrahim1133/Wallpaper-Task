import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get verticalPadding => MediaQuery.of(this).viewPadding.vertical;
  double get horizontalPadding => MediaQuery.of(this).viewPadding.horizontal;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}
extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
    height: toDouble(),
  );
  SizedBox get pw => SizedBox(
    width: toDouble(),
  );
}

extension NavigationExtension on BuildContext {
  void navigateToPush(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  void navigateToPushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  void navigateToPushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),(route) => false,
    );
  }
  void navigateToPop() {
    Navigator.of(this).pop();
  }

}
