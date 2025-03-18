import 'package:flutter/widgets.dart';

class SizeUtils {
  static sizedBottom(BuildContext context) => MediaQuery.of(context).viewPadding.bottom;
  static sizedInsetsBottom(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;
  static sizedInsetsTop(BuildContext context) => MediaQuery.of(context).viewInsets.top;
  static sizedTop(BuildContext context) => MediaQuery.of(context).viewPadding.top;
  static sizedHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static sizedWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double sizedDeviceRatio = 450;
}
