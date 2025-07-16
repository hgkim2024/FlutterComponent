import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';
import 'package:ub_flutter/test/screen/api/utils/utils.dart';
import 'package:ub_flutter/test/screen/subScreen/8_test_dialog_screen.dart';
import 'package:ub_flutter/utils/router/router.dart';
import 'package:ub_flutter/utils/view/button/normal/animated_button.dart';

import '../normal/button_animation_data.dart';
import '../../color.dart';
import '../../image.dart';

class UbVideoThumbnail extends StatefulWidget {
  final VideoModel videoModel;

  const UbVideoThumbnail({
    super.key,
    required this.videoModel,
  });

  @override
  State<UbVideoThumbnail> createState() => _UbVideoThumbnailState();
}

class _UbVideoThumbnailState extends State<UbVideoThumbnail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final double radius = 16.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: tapForwardAnimationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UbAnimatedButton(
      controller: _controller,
      borderRadius: radius,
      onPressed: () {
        context.pushNamed(
          UbTestRoute.videoPlayer.name,
          extra: widget.videoModel,
        );
      },
      throttle: UbButtonThrottle.long,
      child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        // final maxWidth = DataUtils.getPortraitMaxWidth(context);
        // final width = constraints.maxWidth > maxWidth ? maxWidth: constraints.maxWidth;
        final width = constraints.maxWidth;
        final height = width / 1.5;

        return Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image.network(
                  widget.videoModel.detailModuleThumbnail,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: UbGradientColor.thumbnailGradient.gradient,
                  borderRadius: BorderRadius.circular(radius),
                ),
                width: width,
                height: height,
              ),
            ),
            SizedBox(
              height: height,
              child: const Center(
                child: UbSvgImage(
                  image: UbImage.player_outline,
                  width: 48,
                  height: 48,
                  color: UbColor.white,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
