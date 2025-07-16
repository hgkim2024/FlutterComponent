import 'package:flutter/cupertino.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/button/normal/button.dart';
import 'package:ub_flutter/utils/view/button/radio/radio.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../../utils/log/log.dart';

class TestRadioScreen extends StatefulWidget {
  const TestRadioScreen({super.key});

  @override
  State<TestRadioScreen> createState() => _TestRadioScreenState();
}

class _TestRadioScreenState extends State<TestRadioScreen> {
  bool _value = true;
  ValueChanged<bool>? _onChanged = null;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'radio',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UbRadio(
              value: _value,
              onChanged: _onChanged,
              size: UbRadioSize.middle,
              text: UbText(
                'middle radio',
                font: UbFont.body1,
              ),
            ),
            SizedBox(height: 16),
            UbRadio(
              value: _value,
              onChanged: _onChanged,
              size: UbRadioSize.small,
              text: UbText(
                'small radio',
                font: UbFont.body1,
              ),
            ),
            SizedBox(height: 16),
            UbRadio(
              value: _value,
              onChanged: _onChanged,
              size: UbRadioSize.middle,
            ),
            SizedBox(height: 16),
            UbRadio(
              value: _value,
              onChanged: _onChanged,
              size: UbRadioSize.small,
            ),
            SizedBox(height: 16),
            UbButton(
              title: _onChanged == null ? 'active all' : 'disable all',
              onPressed: (){
                setState(() {
                  if (_onChanged == null) {
                    _onChanged = (value) {
                      setState(() {
                        _value = value;
                      });
                    };
                    ubLog.tag(Tag.SCREEN).d('set _onChanged: $_onChanged');
                  } else {
                    _onChanged = null;
                    ubLog.tag(Tag.SCREEN).d('set null');
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
