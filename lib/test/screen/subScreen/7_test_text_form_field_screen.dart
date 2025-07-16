import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/button/normal/button.dart';
import 'package:ub_flutter/utils/view/image.dart';
import 'package:ub_flutter/utils/view/text/text.dart';
import 'package:ub_flutter/utils/view/text/text_form_field.dart';

import '../../../utils/view/text/font.dart';

class TestTextFormFieldSceen extends StatefulWidget {
  TestTextFormFieldSceen({super.key});

  @override
  State<TestTextFormFieldSceen> createState() => _TestTextFormFieldSceenState();
}

class _TestTextFormFieldSceenState extends State<TestTextFormFieldSceen> {
  int? startTime = 12;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'textFormField',
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UbText('defualt', font: UbFont.subtitle1),
                  SizedBox(height: 8),
                  UbTextFormField(
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    initialValue: 'initValue',
                    icon: UbImage.search_outline_small,
                  ),
                  SizedBox(height: 8),
                  UbTextFormField(
                    hintText: 'hint',
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    initialValue: startTime.toString(),
                  ),
                  SizedBox(height: 8),
                  UbTextFormField(
                    hintText: 'hint',
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    initialValue: startTime.toString(),
                    useUnderline: true,
                    icon: UbImage.search_outline_middle,
                  ),
                  SizedBox(height: 8),
                  UbTextFormField(
                    hintText: 'hint',
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    initialValue: startTime.toString(),
                    useUnderline: true,
                  ),
                  SizedBox(height: 16),
                  UbText('error', font: UbFont.subtitle1),
                  SizedBox(height: 8),
                  UbTextFormField(
                    errorText: 'errorText',
                    initialValue: 'initValue',
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                  ),
                  UbTextFormField(
                    errorText: 'errorText',
                    initialValue: 'initValue',
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    useUnderline: true,
                  ),
                  SizedBox(height: 16),
                  UbText('disable', font: UbFont.subtitle1),
                  SizedBox(height: 8),
                  UbTextFormField(
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    initialValue: 'initValue',
                    enabled: false,
                  ),
                  SizedBox(height: 8),
                  UbTextFormField(
                    validator: onStartTimeValidate,
                    onSaved: onStartTimeSaved,
                    initialValue: 'initValue',
                    enabled: false,
                    useUnderline: true,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        UbTextFormField(
                          validator: onStartTimeValidate,
                          onSaved: onStartTimeSaved,
                          initialValue: 'initValue',
                          expand: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  UbButton(
                    title: '검증',
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        _formKey.currentState!.save();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력 해주세요!';
    }

    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }

    final time = int.parse(val);

    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요!';
    }

    return null;
  }

  void onStartTimeSaved(String? val) {
    if (val == null) {
      return;
    }

    startTime = int.parse(val);
  }
}
