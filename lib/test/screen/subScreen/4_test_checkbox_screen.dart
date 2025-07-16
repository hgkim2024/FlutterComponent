import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/button/checkbox/checkbox.dart';
import 'package:ub_flutter/utils/view/color.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/button/switch/switch.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../../utils/data.dart';
import '../../../utils/log/log.dart';
import '../../../utils/view/button/normal/button.dart';

class TestCheckboxScreen extends StatefulWidget {
  const TestCheckboxScreen({super.key});

  @override
  State<TestCheckboxScreen> createState() => _TestCheckboxScreenState();
}

class _TestCheckboxScreenState extends State<TestCheckboxScreen> {
  bool _value = true;
  ValueChanged<bool>? _onChanged = null;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'checkbox',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UbCheckBox(
            value: _value,
            onChanged: _onChanged,
            text: UbText(
              '체크박스',
              font: UbFont.subtitle1,
            ),
          ),
          SizedBox(height: 16),
          UbCheckBox(
            value: _value,
            onChanged: _onChanged,
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: UbButton(
              title: _onChanged == null ? 'active all' : 'disable all',
              onPressed: () {
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
          ),
        ],
      ),
    );
  }
}
