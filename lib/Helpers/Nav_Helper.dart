import 'package:flutter/material.dart';

mixin Nav_Helper {
  void jump(BuildContext context, Widget to, {bool replace = false}) {
    if (replace) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => to));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => to));
    }
  }
}
