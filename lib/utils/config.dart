import 'package:flutter/material.dart';

extension ContextEx on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  double get paddingTop => MediaQuery.paddingOf(this).top;

  SizedBox spacePercentHeight(double percent) => SizedBox(height: height * percent);
  SizedBox get spaceMedium => SizedBox(height: height * 0.05);
  SizedBox get spaceBig => SizedBox(height: height * 0.08);
  SizedBox get spaceSmall => SizedBox(height: 25);
}

abstract class Config {
  // 防止被意外實例化 (Instantiation)
  Config._();

  static const primaryColor = Colors.greenAccent;

  static const borderRadius8 = BorderRadius.all(Radius.circular(8));

  static const outlinedBorder = OutlineInputBorder(borderRadius: borderRadius8);

  static const focusBorder = OutlineInputBorder(
    borderRadius: borderRadius8,
    borderSide: BorderSide(color: primaryColor),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: borderRadius8,
    borderSide: BorderSide(color: Colors.red),
  );
}
