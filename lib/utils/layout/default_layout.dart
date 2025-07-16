import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/utils/view/color.dart';
import 'package:ub_flutter/utils/view/text/font.dart';

import '../view/text/text.dart';


class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const DefaultLayout({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UbColor.white.color,
      appBar: AppBar(
        backgroundColor: UbColor.white.color,
        title: UbText(
          '$title - ${GoRouterState.of(context).matchedLocation}',
          font: UbFont.subtitle2,
          textAlign: TextAlign.left,
          color: UbColor.textStrong,
        ),
      ),
      body: child,
    );
  }
}
