import 'package:flutter/cupertino.dart';

import '../../../data.dart';
import '../../../log/log.dart';
import '../../color.dart';
import 'button_animation_data.dart';
/*
this is scale, color animated custom button.
default animation is scale animation.
optionally add color animation that bg, border.
optionally add child animation.
 */

class UbAnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double borderRadius;

  final Cubic curve;

  final UbColor idleBorderColor;
  final UbColor disabledBorderColor;
  final UbColor pressedBorderColor;

  final UbColor idleBgColor;
  final UbColor disabledBgColor;
  final UbColor pressedBgColor;

  final UbButtonThrottle throttle;
  final AnimationController controller;

  final ValueChanged<bool>? onPressedChanged;
  const UbAnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.borderRadius = 16,

    // under value is animated value

    this.curve = Curves.easeInOut,

    // border color
    this.idleBorderColor = UbColor.clear,
    this.disabledBorderColor = UbColor.clear,
    this.pressedBorderColor = UbColor.clear,

    // bg color
    this.idleBgColor = UbColor.clear,
    this.disabledBgColor = UbColor.clear,
    this.pressedBgColor = UbColor.clear,

    // etc
    this.throttle = UbButtonThrottle.long,
    required this.controller,
    this.onPressedChanged,
  });

  @override
  State<UbAnimatedButton> createState() => _UbAnimatedButtonState();
}

class _UbAnimatedButtonState extends State<UbAnimatedButton> {
  late Animation<double> _scaleAnimation;

  late Animation<Color?> _bgColorAnimation;
  late Animation<Color?> _borderColorAnimation;

  late Animation<Color?> _disabledBgColorAnimation;
  late Animation<Color?> _disabledBorderColorAnimation;

  bool get _disabled => widget.onPressed == null;
  DateTime? _lastTapDownTime;
  DateTime? _lastTapUpTime;
  bool _isOnPressedChanging = true;

  @override
  void initState() {
    super.initState();

    widget.onPressedChanged?.call(_isOnPressedChanging);

    _scaleAnimation = Tween<double>(begin: scaleBegin, end: scaleEnd).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _bgColorAnimation = ColorTween(
      begin: widget.idleBgColor.color,
      end: widget.pressedBgColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _borderColorAnimation = ColorTween(
      begin: widget.idleBorderColor.color,
      end: widget.pressedBorderColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _disabledBgColorAnimation = ColorTween(
      begin: widget.idleBgColor.color,
      end: widget.disabledBgColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _disabledBorderColorAnimation = ColorTween(
      begin: widget.idleBorderColor.color,
      end: widget.disabledBorderColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    if (_disabled) {
      widget.controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant UbAnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.onPressed == null && oldWidget.onPressed != null) ||
        widget.onPressed != null && oldWidget.onPressed == null) {
      _onPressedChanged();
    }
  }

  _onPressedChanged() {
    // ubLog.tag(Tag.SCREEN).xd('onChangedDisableStatus');
    _isOnPressedChanging = true;
    widget.onPressedChanged?.call(_isOnPressedChanging);
    // ubLog.tag(Tag.SCREEN).xd('_isOnPressedChanging $_isOnPressedChanging');

    if (_disabled) {
      widget.controller.duration = animationDuration;
      widget.controller.forward();
    } else {
      widget.controller.duration = const Duration(milliseconds: 0);
      widget.controller.forward();
      widget.controller.duration = animationDuration;
      widget.controller.reverse();
    }
  }

  void _onTapDown(TapDownDetails details) {
    // ubLog.tag(Tag.SCREEN).xd('_onTapDown');
    if (_disabled) return;
    _isOnPressedChanging = false;
    widget.onPressedChanged?.call(_isOnPressedChanging);

    final now = DateTime.now();
    if (_lastTapDownTime != null &&
        now.difference(_lastTapDownTime!).inMilliseconds <
            tapForwardAnimationDuration.inMilliseconds) {
      return;
    }

    _lastTapDownTime = now;

    widget.controller.duration = tapForwardAnimationDuration;
    widget.controller.forward();
  }

  void _onTapUp(TapUpDetails details) async {
    // ubLog.tag(Tag.SCREEN).xd('_onTapUp');
    if (_disabled) return;

    final now = DateTime.now();
    await Future.delayed(tapForwardAnimationDuration);
    widget.controller.duration = tapReverseAnimationDuration;
    await widget.controller.reverse();
    if (_lastTapUpTime != null &&
        now.difference(_lastTapUpTime!).inMilliseconds < widget.throttle.time) {
      return;
    }

    _lastTapUpTime = now;
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    // ubLog.tag(Tag.SCREEN).xd('_onTapCancel');
    if (_disabled) return;

    widget.controller.duration = tapReverseAnimationDuration;
    widget.controller.reverse();
  }

  Animation<Color?> get bgColorAnimation {
    return _disabled || _isOnPressedChanging
        ? _disabledBgColorAnimation
        : _bgColorAnimation;
  }

  Animation<Color?> get borderColorAnimation {
    return _disabled || _isOnPressedChanging
        ? _disabledBorderColorAnimation
        : _borderColorAnimation;
  }

  @override
  Widget build(BuildContext context) {
    // ubLog.tag(Tag.SCREEN).d('super build');
    // ubLog.tag(Tag.SCREEN).xd(
    //       '__disabled - $_disabled, _isOnPressedChanging - $_isOnPressedChanging',
    //     );

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _disabled || _isOnPressedChanging
                  ? 1.0
                  : _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: bgColorAnimation.value,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: borderColorAnimation.value!,
                    width: 1.0,
                  ),
                ),
                child: widget.child,
              ),
            );
          }),
    );
  }
}
