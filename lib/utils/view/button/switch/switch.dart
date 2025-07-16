import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/view/color.dart';

import '../normal/button_animation_data.dart';

enum UbSwitchSize {
  large,
  middle,
  small;

  double get height {
    switch (this) {
      case UbSwitchSize.large:
        return 36;
      case UbSwitchSize.middle:
        return 32;
      case UbSwitchSize.small:
        return 26;
    }
  }

  double get width {
    switch (this) {
      case UbSwitchSize.large:
        return 68;
      case UbSwitchSize.middle:
        return 50;
      case UbSwitchSize.small:
        return 46;
    }
  }

  double get radius {
    switch (this) {
      case UbSwitchSize.large:
        return 24;
      case UbSwitchSize.middle:
        return 16;
      case UbSwitchSize.small:
        return 16;
    }
  }

  double get thumbSize {
    switch (this) {
      case UbSwitchSize.large:
        return 30;
      case UbSwitchSize.middle:
        return 26;
      case UbSwitchSize.small:
        return 20;
    }
  }
}

class UbSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final UbSwitchSize size;

  const UbSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.size = UbSwitchSize.large,
  });

  @override
  _UbSwitchState createState() => _UbSwitchState();
}

class _UbSwitchState extends State<UbSwitch> {
  Color get _color {
    if (widget.onChanged == null) {
      return widget.value
          ? UbColor.disabled.color
          : UbColor.disabledLight.color;
    } else {
      return widget.value
          ? UbColor.primaryNormal.color
          : UbColor.primaryAlternative.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeInOut,
        width: widget.size.width,
        height: widget.size.height,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(widget.size.radius),
        ),
        child: AnimatedAlign(
          duration: animationDuration,
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            width: widget.size.thumbSize,
            height: widget.size.thumbSize,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(widget.size.thumbSize / 2),
            ),
          ),
        ),
      ),
    );
  }
}
