import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/view/text/font.dart';

import '../../../utils/data.dart';
import '../../../utils/layout/default_layout.dart';
import '../../../utils/log/log.dart';
import '../../../utils/view/button/normal/button.dart';
import '../../../utils/view/button/switch/switch.dart';
import '../../../utils/view/color.dart';
import '../../../utils/view/text/text.dart';

class TestSwitchScreen extends StatefulWidget {
  const TestSwitchScreen({super.key});

  @override
  State<TestSwitchScreen> createState() => _TestSwitchScreenState();
}

class _TestSwitchScreenState extends State<TestSwitchScreen> {
  bool _value = true;
  ValueChanged<bool>? _onChanged = null;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'checkbox',
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            UbSwitch(
              value: _value,
              onChanged: _onChanged,
              size: UbSwitchSize.large,
            ),
            SizedBox(height: 16),
            UbSwitch(
              value: _value,
              onChanged: _onChanged,
              size: UbSwitchSize.middle,
            ),
            SizedBox(height: 16),
            UbSwitch(
              value: _value,
              onChanged: _onChanged,
              size: UbSwitchSize.small,
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
      ),
    );
  }
}
