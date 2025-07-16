import 'package:flutter/cupertino.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../../utils/view/color.dart';

class TestTextScreen extends StatelessWidget {
  final double _padding = 12;

  const TestTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'text',
      child: ListView.separated(
        itemCount: UbFont.values.length + 1,
        itemBuilder: (context, index) {
          if (index == UbFont.values.length) {
            return Column(
              children: [
                UbHighlightText(
                  text: "This is a highlight text",
                  highlightTexts: ['highlight'],
                  font: UbFont.body1,
                ),
                SizedBox(height: _padding),
                UbHighlightText(
                  text: "This is a highlight text",
                  highlightTexts: ['highlight', 'text', 'a'],
                  highlightFonts: [
                    UbFont.title1,
                    UbFont.subtitle1,
                    UbFont.extraTitle
                  ],
                  highlightColors: [UbColor.red, UbColor.purple],
                  font: UbFont.body1,
                  fontColor: UbColor.textNormal,
                ),
              ],
            );
          } else {
            return Center(
              child: UbText(
                UbFont.values[index].name,
                font: UbFont.values[index],
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: _padding);
        },
      ),
    );
  }
}
