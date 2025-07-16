import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';
import 'package:ub_flutter/test/screen/subScreen/8_test_dialog_screen.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/dialog/dialog.dart';
import 'package:ub_flutter/utils/log/log.dart';
import 'package:ub_flutter/utils/view/button/normal/button_animation_data.dart';
import 'package:ub_flutter/utils/view/color.dart';
import 'package:ub_flutter/utils/view/slider.dart';
import 'package:ub_flutter/utils/view/text/text.dart';
import 'package:video_player/video_player.dart';

import '../../text/font.dart';

class UbVideoPlayerScreen extends StatefulWidget {
  final VideoModel videoModel;

  const UbVideoPlayerScreen({
    super.key,
    required this.videoModel,
  });

  @override
  State<UbVideoPlayerScreen> createState() => _UbVideoPlayerScreenState();
}

class _UbVideoPlayerScreenState extends State<UbVideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _showIcons = false;
  bool _canPop = true;
  final Duration moveDuration = const Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _initController();
  }

  _initController() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoModel.detailModuleVideo),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});

      final curPlayTime = _controller.value.position.inSeconds;
      final totalPlayTime = _controller.value.duration.inSeconds;

      ubLog
          .tag(Tag.SCREEN)
          .d('video play time - $curPlayTime / $totalPlayTime');

      if (curPlayTime > 0 && curPlayTime >= totalPlayTime && _canPop) {
        _canPop = false;
        context.pop();
      }
    });

    setState(() {});
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  _onTap() {
    setState(() {
      _showIcons = !_showIcons;
    });
  }

  _onReversePressed() {
    final currentPosition = _controller.value.position;
    Duration position = const Duration();

    if (currentPosition.inSeconds > moveDuration.inSeconds) {
      position = currentPosition - moveDuration;
    }

    _controller.seekTo(position);
  }

  _onPlayPressed() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  _onForwardPressed() {
    final maxPosition = _controller.value.duration;
    final currentPosition = _controller.value.position;

    Duration position = const Duration();

    if ((maxPosition - moveDuration).inSeconds > currentPosition.inSeconds) {
      position = currentPosition + moveDuration;
    } else {
      position = maxPosition;
    }

    if (kDebugMode) {
      _controller.seekTo(position);
    }
  }

  onSliderChanged(double value) {
    if (kDebugMode) {
      // final position = Duration(seconds: value.toInt());
      // _controller.seekTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UbColor.black.color,
      body: GestureDetector(
        onTap: _onTap,
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            if (_showIcons)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: UbColor.videoDimmed.color,
              ),
            _DoubleClickArea(
              onTap: _onTap,
              onLeftAreaDoubleTap: _onReversePressed,
              onRightAreaDoubleTap: _onForwardPressed,
            ),
            if (_showIcons)
              SafeArea(
                child: Stack(
                  children: [
                    _Top(
                      videoModel: widget.videoModel,
                    ),
                    _PlayButton(
                      onReversePressed: _onReversePressed,
                      onPlayPressed: _onPlayPressed,
                      onForwardPressed: _onForwardPressed,
                      isPlaying: _controller.value.isPlaying,
                    ),
                    _Bottom(
                      curPosition: _controller.value.position,
                      endPosition: _controller.value.duration,
                      onSliderChanged: onSliderChanged,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  final VideoModel videoModel;

  const _Top({
    super.key,
    required this.videoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: UbText(
                videoModel.detailModuleVideoTitle,
                font: UbFont.title3,
                color: UbColor.white,
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close_rounded),
              color: UbColor.white.color,
              iconSize: 32.0,
              onPressed: () {
                UbDialog.show(
                  context: context,
                  title: '${videoModel.detailModuleVideoTitle} 종료',
                  content: '영상을 종료하시겠습니까?',
                  cancelTitle: '취소',
                  confirmTitle: '확인',
                  onConfirmPressed: () {
                    context.pop();
                    context.pop();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DoubleClickArea extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLeftAreaDoubleTap;
  final VoidCallback onRightAreaDoubleTap;

  const _DoubleClickArea({
    super.key,
    required this.onTap,
    required this.onLeftAreaDoubleTap,
    required this.onRightAreaDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _DoubleTapRippleArea(
                  onDoubleTap: onLeftAreaDoubleTap,
                ),
              ),
              Expanded(
                child: _DoubleTapRippleArea(
                  onDoubleTap: onRightAreaDoubleTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DoubleTapRippleArea extends StatefulWidget {
  final VoidCallback onDoubleTap;

  const _DoubleTapRippleArea({
    required this.onDoubleTap,
  });

  @override
  State<_DoubleTapRippleArea> createState() => _DoubleTapRippleAreaState();
}

class _DoubleTapRippleAreaState extends State<_DoubleTapRippleArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _triggerRipple(TapDownDetails details) {
    setState(() {
      _tapPosition = details.localPosition;
    });
    _controller.forward(from: 0.0);
    widget.onDoubleTap();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _triggerRipple,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _RipplePainter(
                    progress: _rippleAnimation.value,
                    color: UbColor.disabledLight.color,
                    tapPosition: _tapPosition,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Offset? tapPosition;

  _RipplePainter({
    required this.progress,
    required this.color,
    required this.tapPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (tapPosition == null) return;

    final paint = Paint()
      ..color = color.withOpacity((1.0 - progress) / 2)
      ..style = PaintingStyle.fill;

    final radius = size.shortestSide * progress / 2;
    canvas.drawCircle(tapPosition!, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.tapPosition != tapPosition;
  }
}

class _PlayButton extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _PlayButton({
    super.key,
    required this.onReversePressed,
    required this.onPlayPressed,
    required this.onForwardPressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 40.0;

    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: UbColor.white.color,
            onPressed: onReversePressed,
            icon: const Icon(Icons.fast_rewind_rounded),
            iconSize: iconSize,
          ),
          IconButton(
            color: UbColor.white.color,
            onPressed: onPlayPressed,
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            ),
            iconSize: iconSize,
          ),
          IconButton(
            color: kDebugMode ? UbColor.white.color : UbColor.clear.color,
            onPressed: onForwardPressed,
            icon: const Icon(Icons.fast_forward_rounded),
            iconSize: iconSize,
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final Duration curPosition;
  final Duration endPosition;
  final ValueChanged<double> onSliderChanged;

  const _Bottom({
    super.key,
    required this.curPosition,
    required this.endPosition,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: UbText(
              time,
              font: UbFont.caption1,
              color: UbColor.white,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: UbSlider(
              value: curPosition.inSeconds.toDouble(),
              max: endPosition.inSeconds.toDouble(),
              thumbRadius: 8,
              trackHeight: 4,
              onChanged: onSliderChanged,
            ),
          ),
        ],
      ),
    );
  }

  // ex) 0:21 / 1:34
  String get time {
    final String startMinutes = curPosition.inMinutes.toString();
    final String startSecond =
        (curPosition.inSeconds % 60).toString().padLeft(2, '0');
    final String endMinutes = endPosition.inMinutes.toString();
    final String endSecond =
        (endPosition.inSeconds % 60).toString().padLeft(2, '0');
    return '$startMinutes:$startSecond / $endMinutes:$endSecond';
  }
}
