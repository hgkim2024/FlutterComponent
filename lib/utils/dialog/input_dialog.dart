import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/view/image.dart';
import 'package:ub_flutter/utils/view/text/text_form_field.dart';

import '../../test/screen/api/utils/utils.dart';
import '../view/button/normal/button.dart';
import '../view/button/normal/button_animation_data.dart';
import '../view/button/normal/button_size.dart';
import '../view/button/normal/button_type.dart';
import '../view/color.dart';
import '../view/text/font.dart';
import '../view/text/text.dart';

class UbInputDialog extends StatefulWidget {
  final String title;
  final String? hint;
  final String? initialTextValue;
  final String? errorText;
  final ValueChanged<String>? onTextChanged;
  final String confirmTitle;
  final ValueChanged<String>? onConfirmPressed;

  const UbInputDialog({
    super.key,
    required this.title,
    this.hint,
    this.initialTextValue,
    this.errorText,
    this.onTextChanged,
    required this.confirmTitle,
    this.onConfirmPressed,
  });

  @override
  State<UbInputDialog> createState() => _UbInputDialogState();

  static show({
    required BuildContext context,
    required String title,
    String? hint,
    String? initialTextValue,
    String? errorText,
    ValueChanged<String>? onTextChanged,
    String? confirmTitle,
    ValueChanged<String>? onConfirmPressed,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierColor: UbColor.backgroundDimmed.color,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return UbInputDialog(
          title: title,
          hint: hint,
          initialTextValue: initialTextValue,
          errorText: errorText,
          onTextChanged: onTextChanged,
          confirmTitle: confirmTitle ?? '확인',
          onConfirmPressed: onConfirmPressed,
        );
      },
    );
  }
}

class _UbInputDialogState extends State<UbInputDialog> {
  String _changedText = '';
  VoidCallback? _onPressed;

  @override
  void initState() {
    super.initState();

    _onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 8.0;
    const double horizontalMargin = 32;
    const double horizontalPadding = 24;
    const double textHorizontalPadding = 24;
    const double verticalPadding = 32;
    const double verticalGap = 12;

    return Center(
      child: Material(
        color: UbColor.clear.color,
        child: Container(
          width: DataUtils.getPortraitMaxWidth(context) - horizontalMargin,
          decoration: BoxDecoration(
            color: UbColor.white.color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: textHorizontalPadding,
                ),
                child: Column(
                  children: [
                    UbText(
                      widget.title,
                      font: UbFont.title3,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: verticalGap),
                  ],
                ),
              ),
              UbTextFormField(
                hintText: widget.hint,
                font: UbFont.inputSmall,
                initialValue: widget.initialTextValue,
                useUnderline: true,
                icon: UbImage.pencil_outline_small,
                errorText: widget.errorText,
                onChanged: (value) {
                  setState(() {
                    _changedText = value;
                    widget.onTextChanged?.call(value);
                    _onPressed = onPressed;
                  });
                },
              ),
              const SizedBox(height: verticalGap * 2),
              UbButton(
                title: widget.confirmTitle,
                type: UbButtonType.primary,
                size: UbButtonSize.middle,
                throttle: UbButtonThrottle.long,
                onPressed: _onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  VoidCallback? get onPressed {
    return widget.onConfirmPressed == null ||
        _changedText.isEmpty ||
        widget.errorText != null
        ? null
        : () {
      widget.onConfirmPressed!.call(_changedText);
    };
  }
}
