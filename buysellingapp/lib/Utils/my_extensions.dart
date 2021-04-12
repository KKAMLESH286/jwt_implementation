import 'package:flutter/material.dart';

extension widgets_extension on Widget {
  InkWell addInkwell({@required Function onClick}) {
    return InkWell(
      child: this,
      onTap: () => onClick() ?? () {},
    );
  }

  GestureDetector addGesture({@required Function onClick}) {
    return GestureDetector(
      child: this,
      onTap: () => onClick() ?? () {},
    );
  }

  Padding addPadding(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Padding addLeftPadding(@required double value) {
    return Padding(padding: EdgeInsets.only(left: value), child: this);
  }

  Padding addRightPadding(double value) {
    return Padding(padding: EdgeInsets.only(right: value), child: this);
  }

  Padding addTopPadding(@required double value) {
    return Padding(padding: EdgeInsets.only(top: value), child: this);
  }

  Padding addBottomPadding(@required double value) {
    return Padding(padding: EdgeInsets.only(bottom: value), child: this);
  }

  Padding addOnlyPadding(
      {double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(
        padding:
            EdgeInsets.only(top: top, bottom: bottom, right: right, left: left),
        child: this);
  }

  Row alignToRight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [this],
    );
  }
}

extension text_extension on Text {
  Text addTextStyle(@required TextStyle style) {
    return Text(
      this.data,
      style: style,
      textAlign: this.textAlign,
    );
  }
}

extension num_extension on num {
  toHorizontalSpace() {
    return SizedBox(
      width: this.toDouble(),
    );
  }

  toVerticalSpace() {
    return SizedBox(
      height: this.toDouble(),
    );
  }
}

extension bool_extension on bool {
  bool not() {
    return !this;
  }
}

extension object_extension on Object {
  bool isNullOrEmpty() {
    if (this is String)
      return ((this as String) == null || (this as String).isEmpty);
    else if (this is List)
      return ((this as List) == null || (this as List).isEmpty);
    else
      return (this == null);
  }

  bool isNotNullOrEmpty() {
    return isNullOrEmpty().not();
  }
}
