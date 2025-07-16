import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ub_flutter/utils/view/color.dart';

enum UbImage {
  chevron_left,
  chevron_right,
  chevron_down,
  calendar_plus_outline,
  calendar_time_outline,
  category,
  chart_infographic,
  check_point_outline,
  cicle_x,
  clock_outline,
  eye,
  image_add,
  info_outline,
  invisible,
  map_outline,
  message_outline,
  pencil_outline,
  pencil_outline_small,
  search_outline_small,
  search_outline_middle,
  pin_line_outline,
  ping_outline,
  player_outline,
  plus,
  repeat_outline,
  square_dottedline_plus,
  square_full_plus,
  square_rounded_plus_outline,
  stop,
  trash,
  urgent_outline,
  user,
  users_plus_outline,
  volume,
  checkbox_off,
  checkbox_on,
  radio_small_on,
  radio_small_off,
  radio_small_disabled_on,
  radio_small_disabled_off,
  radio_middle_on,
  radio_middle_off,
  radio_middle_disabled_on,
  radio_middle_disabled_off,

  audio_play_disabled,
  audio_play,
  audio_record_disabled,
  audio_record,
  audio_stop_disabled,
  audio_stop,
  audio_waveform,

  none;

  String get path {
    return 'asset/image/$name.svg';
  }
}

class UbSvgImage extends StatelessWidget {
  final UbImage image;
  final UbColor? color;
  final Color? materialColor;
  final ColorFilter? colorFilter;
  final double? width; // null = original image size
  final double? height; // null = original image size
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final Clip clipBehavior;

  const UbSvgImage({
    super.key,
    required this.image,
    this.color,
    this.materialColor,
    this.colorFilter,
    this.width, // null = original image size
    this.height, // null = original image size
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image.path,
      colorFilter: getColorFilter(),
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      clipBehavior: clipBehavior,
    );
  }

  ColorFilter? getColorFilter() {
    if (colorFilter == null) {
      if (materialColor != null) {
        return ColorFilter.mode(materialColor!, BlendMode.srcATop);
      }

      return color == null
          ? null
          : ColorFilter.mode(color!.color, BlendMode.srcATop);
    } else {
      return colorFilter;
    }
  }
}
