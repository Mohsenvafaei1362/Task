import 'package:flutter/material.dart';

extension MediaQueryExtention on BuildContext {
  double get screenheight => MediaQuery.of(this).size.height;
  double get screenwidth => MediaQuery.of(this).size.width;
}
