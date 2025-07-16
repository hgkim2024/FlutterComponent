import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/view/color.dart';
import 'package:ub_flutter/utils/view/image.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../../log/log.dart';
import 'animated_button.dart';
import 'button_animation_data.dart';
import 'button_icon.dart';
import 'button_size.dart';
import 'button_type.dart';

class UbButton extends StatefulWidget {
  final String title;
  final UbButtonSize size;
  final UbButtonType type;
  final UbButtonIcon icon;
  final UbButtonThrottle throttle;
  final VoidCallback? onPressed;

  const UbButton({
    super.key,
    required this.title,
    this.size = UbButtonSize.large,
    this.type = UbButtonType.primary,
    this.onPressed,
    this.throttle = UbButtonThrottle.short,
    this.icon = UbButtonIcon.none,
  });

  @override
  State<UbButton> createState() => _UbButtonState();
}

class _UbButtonState extends State<UbButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _fontColorAnimation;
  late Animation<Color?> _disabledFontColorAnimation;

  bool _isOnPressedChanging = true;
  final Cubic _curve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: tapForwardAnimationDuration,
      vsync: this,
    );
    _fontColorAnimation = ColorTween(
      begin: _type.getFontColor(state: UbButtonState.idle).color,
      end: _type.getFontColor(state: UbButtonState.pressed).color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );
    _disabledFontColorAnimation = ColorTween(
      begin: _type.getFontColor(state: UbButtonState.idle).color,
      end: _type.getFontColor(state: UbButtonState.disabled).color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _disabled {
    return widget.onPressed == null;
  }

  UbButtonType get _type {
    return widget.type;
  }

  Animation<Color?> get fontColorAnimation {
    return _disabled || _isOnPressedChanging
        ? _disabledFontColorAnimation
        : _fontColorAnimation;
  }

  @override
  Widget build(BuildContext context) {
    // ubLog.tag(Tag.SCREEN).d('child build');

    return UbAnimatedButton(
      controller: _controller,
      onPressed: widget.onPressed,
      curve: _curve,
      idleBgColor: _type.getBgColor(state: UbButtonState.idle),
      pressedBgColor: _type.getBgColor(state: UbButtonState.pressed),
      disabledBgColor: _type.getBgColor(state: UbButtonState.disabled),
      idleBorderColor: _type.getBorderColor(state: UbButtonState.idle),
      pressedBorderColor: _type.getBorderColor(state: UbButtonState.pressed),
      disabledBorderColor: _type.getBorderColor(state: UbButtonState.disabled),
      borderRadius: widget.size.radius,
      throttle: widget.throttle,
      onPressedChanged: (value) {
        _isOnPressedChanging = value;
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            height: widget.size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon == UbButtonIcon.left)
                  UbSvgImage(
                    image: UbImage.chevron_left,
                    width: widget.size.iconHeight,
                    height: widget.size.iconHeight,
                    materialColor: fontColorAnimation.value,
                  ),
                UbText(
                  widget.title,
                  font: widget.size.font,
                  materialColor: fontColorAnimation.value,
                ),
                if (widget.icon == UbButtonIcon.right)
                  UbSvgImage(
                    image: UbImage.chevron_right,
                    width: widget.size.iconHeight,
                    height: widget.size.iconHeight,
                    materialColor: fontColorAnimation.value,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
