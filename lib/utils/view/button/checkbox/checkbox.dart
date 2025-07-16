import 'package:flutter/cupertino.dart';
import 'package:ub_flutter/utils/view/color.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../image.dart';
import '../normal/button_animation_data.dart';

class UbCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final UbText? text;

  const UbCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.text,
  });

  @override
  State<UbCheckBox> createState() => _UbCheckBoxState();
}

class _UbCheckBoxState extends State<UbCheckBox> {
  final double _checkboxSize = 20;
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
              duration: animationDuration,

              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale:
                        Tween<double>(begin: scaleBegin, end: scaleEnd).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.easeInOut),
                    ),
                    child: child,
                  ),
                );
              },
              child: widget.value
                  ? UbSvgImage(
                      key: ValueKey(
                          'checked${widget.onChanged == null ? '' : 'disabled'}'),
                      image: UbImage.checkbox_on,
                      height: _checkboxSize,
                      width: _checkboxSize,
                      colorFilter: widget.onChanged == null
                          ? ColorFilter.mode(
                              UbColor.disabledLight.color.withOpacity(0.8),
                              BlendMode.srcATop)
                          : null,
                    )
                  : UbSvgImage(
                      key: ValueKey(
                          'unchecked${widget.onChanged == null ? '' : 'disabled'}'),
                      image: UbImage.checkbox_off,
                      height: _checkboxSize,
                      width: _checkboxSize,
                      colorFilter: widget.onChanged == null
                          ? ColorFilter.mode(
                              UbColor.disabledLight.color.withOpacity(0.8),
                              BlendMode.srcATop)
                          : null,
                    ),
            ),
          ),
          const SizedBox(width: 4),
          if (widget.text != null) widget.text!,
        ],
      ),
    );
  }
}
