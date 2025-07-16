import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/view/color.dart';

class UbSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double thumbRadius;
  final double trackHeight;

  UbSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1.0,
    this.thumbRadius = 12.0,
    this.trackHeight = 16.0,
  }) : super(key: key);

  @override
  _UbSliderState createState() => _UbSliderState();
}

class _UbSliderState extends State<UbSlider> {
  @override
  Widget build(BuildContext context) {
    final height = widget.thumbRadius * 2 > widget.trackHeight
        ? widget.thumbRadius * 2
        : widget.trackHeight;

    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        thumbColor: UbColor.primarySupport.color,
        trackHeight: widget.trackHeight,
        overlayColor: Colors.transparent,
        thumbShape:
            RoundSliderThumbShape(enabledThumbRadius: widget.thumbRadius),
        trackShape: GradientSliderTrackShape(),
      ),
      child: SizedBox(
        height: height,
        child: Center(
          child: Container(
            height: widget.trackHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.thumbRadius * 2),
              child: Slider(
                value: widget.value,
                min: widget.min,
                max: widget.max,
                onChanged: (newValue) {
                  widget.onChanged(newValue);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackWidth = parentBox.size.width;
    final Offset trackOffset = offset;
    return Rect.fromLTWH(
        trackOffset.dx, trackOffset.dy, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Paint paint = Paint();
    final double trackWidth = parentBox.size.width;
    final double thumbPosition = thumbCenter.dx - offset.dx;

    // 그라디언트 적용
    paint.shader = UbGradientColor.slider.gradient.createShader(
      Rect.fromLTWH(offset.dx, 0, trackWidth, sliderTheme.trackHeight!),
    );

    // 그라디언트 트랙 (둥근 모서리 적용)
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            offset.dx, offset.dy, trackWidth, sliderTheme.trackHeight!),
        Radius.circular(20), // 원하는 cornerRadius 값
      ),
      paint,
    );

    // 썸 이후 회색 영역 (둥근 모서리 적용)
    if (thumbPosition < trackWidth) {
      paint.shader = null;
      paint.color = UbColor.disabledLight.color;

      context.canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(thumbPosition + offset.dx, offset.dy,
              trackWidth - thumbPosition, sliderTheme.trackHeight!),
          Radius.circular(20), // 원하는 cornerRadius 값
        ),
        paint,
      );
    }

    // 눈금 그리기
    final int tickCount = UbGradientColor.slider.gradient.colors.length;
    final double tickSpacing = trackWidth / tickCount;

    paint.color = UbColor.white.color;

    for (int i = 1; i <= tickCount - 1; i++) {
      final double tickX = offset.dx + (i * tickSpacing);
      if (tickX >= thumbPosition + offset.dx) {
        // 눈금에 둥근 모서리 적용 (세로선 형태)
        context.canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              tickX - 2, // 눈금 위치
              offset.dy + (sliderTheme.trackHeight! * 0.375),
              2, // 눈금 너비
              sliderTheme.trackHeight! * 0.25, // 눈금 높이
            ),
            Radius.circular(1), // 눈금의 cornerRadius
          ),
          paint,
        );
      }
    }
  }
}
