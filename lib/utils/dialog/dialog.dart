import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/test/screen/api/utils/utils.dart';
import 'package:ub_flutter/utils/view/button/normal/button.dart';
import 'package:ub_flutter/utils/view/button/normal/button_animation_data.dart';
import 'package:ub_flutter/utils/view/button/normal/button_size.dart';
import 'package:ub_flutter/utils/view/button/normal/button_type.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../view/color.dart';

class UbDialog extends Dialog {
  final String? title;
  final String? content;
  final UbHighlightText? highlightText;
  final String confirmTitle;
  final String? cancelTitle;
  final VoidCallback? onConfirmPressed;
  final VoidCallback? onCancelPressed;

  const UbDialog({
    super.key,
    this.title,
    this.content,
    this.highlightText,
    this.confirmTitle = '확인',
    this.cancelTitle,
    this.onConfirmPressed,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 8.0;
    const double horizontalMargin = 32.0;
    const double horizontalPadding = 24.0;
    const double textHorizontalPadding = 24.0;
    const double verticalPadding = 32.0;
    const double verticalGap = 12.0;
    const double buttonBetweenGap = 8.0;

    return Center(
      child: Material(
        color: UbColor.clear.color,
        child: Container(
          width: DataUtils.getPortraitMaxWidth(context) - horizontalMargin,
          decoration: BoxDecoration(
            color: UbColor.white.color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          // color: UbColor.white.color,
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                UbText(
                  title!,
                  font: UbFont.title3,
                  textAlign: TextAlign.center,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: textHorizontalPadding),
                child: Column(
                  children: [
                    if (title != null) const SizedBox(height: verticalGap),
                    if (highlightText != null) highlightText!,
                    if (highlightText != null)
                      const SizedBox(height: verticalGap),
                    if (highlightText == null && content != null)
                      UbHighlightText(text: content!, font: UbFont.body2),
                    if (highlightText == null && content != null)
                      const SizedBox(height: verticalGap),
                    const SizedBox(height: verticalGap),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cancelTitle != null)
                    Expanded(
                      flex: 1,
                      child: UbButton(
                        title: cancelTitle!,
                        type: UbButtonType.primaryLine,
                        size: UbButtonSize.middle,
                        throttle: UbButtonThrottle.long,
                        onPressed: onCancelPressed ??
                            () {
                              context.pop();
                            },
                      ),
                    ),
                  if (cancelTitle != null)
                    const SizedBox(width: buttonBetweenGap),
                  Expanded(
                    flex: 1,
                    child: UbButton(
                      title: confirmTitle,
                      type: UbButtonType.primary,
                      size: UbButtonSize.middle,
                      throttle: UbButtonThrottle.long,
                      onPressed: onConfirmPressed ??
                          () {
                            context.pop();
                          },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static show({
    required BuildContext context,
    String? title,
    String? content,
    UbHighlightText? highlightText,
    String? confirmTitle,
    String? cancelTitle,
    VoidCallback? onConfirmPressed,
    VoidCallback? onCancelPressed,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierColor: UbColor.backgroundDimmed.color,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return UbDialog(
          title: title,
          content: content,
          highlightText: highlightText,
          confirmTitle: confirmTitle ?? "확인",
          cancelTitle: cancelTitle,
          onConfirmPressed: onConfirmPressed,
          onCancelPressed: onCancelPressed,
        );
      },
    );
  }
}
