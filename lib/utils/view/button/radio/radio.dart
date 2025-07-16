import 'package:flutter/cupertino.dart';

import '../../image.dart';
import '../../text/text.dart';
import '../normal/button_animation_data.dart';

enum UbRadioSize {
  middle,
  small;

  double get _size {
    switch (this) {
      case UbRadioSize.middle:
        return 16;
      case UbRadioSize.small:
        return 20;
    }
  }

  UbSvgImage get onImage {
    switch (this) {
      case UbRadioSize.middle:
        return UbSvgImage(
          key: const ValueKey('radio_middle_on'),
          image: UbImage.radio_middle_on,
          width: _size,
          height: _size,
        );
      case UbRadioSize.small:
        return UbSvgImage(
          key: const ValueKey('radio_small_on'),
          image: UbImage.radio_small_on,
          width: _size,
          height: _size,
        );
    }
  }

  UbSvgImage get offImage {
    switch (this) {
      case UbRadioSize.middle:
        return UbSvgImage(
          key: const ValueKey('radio_middle_off'),
          image: UbImage.radio_middle_off,
          width: _size,
          height: _size,
        );
      case UbRadioSize.small:
        return UbSvgImage(
          key: const ValueKey('radio_small_off'),
          image: UbImage.radio_small_off,
          width: _size,
          height: _size,
        );
    }
  }

  UbSvgImage get disabledOnImage {
    switch (this) {
      case UbRadioSize.middle:
        return UbSvgImage(
          key: const ValueKey('radio_middle_disabled_on'),
          image: UbImage.radio_middle_disabled_on,
          width: _size,
          height: _size,
        );
      case UbRadioSize.small:
        return UbSvgImage(
          key: const ValueKey('radio_small_disabled_on'),
          image: UbImage.radio_small_disabled_on,
          width: _size,
          height: _size,
        );
    }
  }

  UbSvgImage get disabledOffImage {
    switch (this) {
      case UbRadioSize.middle:
        return UbSvgImage(
          key: const ValueKey('radio_middle_disabled_off'),
          image: UbImage.radio_middle_disabled_off,
          width: _size,
          height: _size,
        );
      case UbRadioSize.small:
        return UbSvgImage(
          key: const ValueKey('radio_small_disabled_off'),
          image: UbImage.radio_small_disabled_off,
          width: _size,
          height: _size,
        );
    }
  }
}

class UbRadio extends StatefulWidget {
  final bool value;
  final UbRadioSize size;
  final ValueChanged<bool>? onChanged;
  final UbText? text;

  const UbRadio({
    super.key,
    required this.value,
    this.size = UbRadioSize.middle,
    this.onChanged,
    this.text,
  });

  @override
  State<UbRadio> createState() => _UbRadioState();
}

class _UbRadioState extends State<UbRadio> {
  final double scaleBegin = 1.5;
  final double scaleEnd = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onChanged?.call(!widget.value);
            },
            child: AnimatedSwitcher(
              duration: animationDuration, // 애니메이션 지속 시간
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: scaleBegin, end: scaleEnd).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.easeInOut),
                    ),
                    child: child,
                  ),
                );
              },
              child: image,
            ),
          ),
          const SizedBox(width: 4),
          if (widget.text != null) widget.text!,
        ],
      ),
    );
  }

  UbSvgImage get image {
    if (widget.onChanged == null) {
      return widget.value ? widget.size.disabledOnImage : widget.size.disabledOffImage;
    } else {
      return widget.value ? widget.size.onImage : widget.size.offImage;
    }
  }
}
