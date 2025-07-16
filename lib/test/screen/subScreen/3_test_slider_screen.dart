import 'package:flutter/cupertino.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/slider.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../../utils/data.dart';
import '../../../utils/log/log.dart';

class TestSliderScreen extends StatefulWidget {
  const TestSliderScreen({super.key});

  @override
  State<TestSliderScreen> createState() => _TestSliderScreenState();
}

class _TestSliderScreenState extends State<TestSliderScreen> {
  double value = 50;

  void onChanged(double value) {
    setState(() {
      this.value = value;
      ubLog.tag(Tag.SCREEN).d('value: ${value.toStringAsFixed(2)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Slider',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UbText(
            'Value: ${value.toStringAsFixed(2)}',
            font: UbFont.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UbSlider(
              value: value,
              onChanged: onChanged,
              min: 0,
              max: 100,
            ),
          ),
        ],
      ),
    );
  }
}
