import 'package:flutter/cupertino.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/log/log.dart';
import 'package:ub_flutter/utils/view/audio/audio_button.dart';
import 'package:ub_flutter/utils/view/button/normal/button_animation_data.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../color.dart';

class UbAudio extends StatefulWidget {
  final String title;
  final UbAudioType type;

  // audio
  final String? url;
  final Duration totalDuration;

  // record
  final bool disabled;
  final ValueChanged<String>? onFilePathChanged;

  const UbAudio({
    super.key,
    required this.title,
    required this.type,

    // audio
    this.url,
    this.totalDuration = Duration.zero,

    // record
    this.disabled = false,
    this.onFilePathChanged,
  });

  @override
  State<UbAudio> createState() => _UbAudioState();
}

class _UbAudioState extends State<UbAudio> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDisableChanging = true;
  final Cubic _curve = Curves.easeInOut;

  late Animation<Color?> _bgColorAnimation;
  late Animation<Color?> _disabledBgColorAnimation;
  final UbColor _idleBgColor = UbColor.white;
  final UbColor _disabledBgColor = UbColor.disabledLight;
  final UbColor _pressedBgColor = UbColor.white;

  late Animation<Color?> _borderColorAnimation;
  late Animation<Color?> _disabledBorderColorAnimation;
  final UbColor _idleBorderColor = UbColor.lineOnWhite;
  final UbColor _disabledBorderColor = UbColor.clear;
  final UbColor _pressedBorderColor = UbColor.lineOnWhite;

  late Animation<Color?> _fontColorAnimation;
  late Animation<Color?> _disabledFontColorAnimation;
  final UbColor _idleFontColor = UbColor.textNormal;
  final UbColor _disabledFontColor = UbColor.textCaption;
  final UbColor _pressedFontColor = UbColor.textNormal;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    _bgColorAnimation = ColorTween(
      begin: _idleBgColor.color,
      end: _pressedBgColor.color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );

    _disabledBgColorAnimation = ColorTween(
      begin: _idleBgColor.color,
      end: _disabledBgColor.color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );

    _borderColorAnimation = ColorTween(
      begin: _idleBorderColor.color,
      end: _pressedBorderColor.color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );

    _disabledBorderColorAnimation = ColorTween(
      begin: _idleBorderColor.color,
      end: _disabledBorderColor.color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );

    _fontColorAnimation = ColorTween(
      begin: _idleFontColor.color,
      end: _pressedFontColor.color,
    ).animate(
      CurvedAnimation(parent: _controller, curve: _curve),
    );
    _disabledFontColorAnimation = ColorTween(
      begin: _idleFontColor.color,
      end: _disabledFontColor.color,
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
    switch (widget.type) {
      case UbAudioType.play:
        return widget.url == null;
      case UbAudioType.record:
        return widget.disabled;
    }
  }
  Animation<Color?> get bgColorAnimation {
    return _disabled || _isDisableChanging
        ? _disabledBgColorAnimation
        : _bgColorAnimation;
  }

  Animation<Color?> get borderColorAnimation {
    return _disabled || _isDisableChanging
        ? _disabledBorderColorAnimation
        : _borderColorAnimation;
  }

  Animation<Color?> get fontColorAnimation {
    return _disabled || _isDisableChanging
        ? _disabledFontColorAnimation
        : _fontColorAnimation;
  }

  @override
  Widget build(BuildContext context) {
    // ubLog.tag(Tag.SCREEN).d('audio build');

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: bgColorAnimation.value,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: borderColorAnimation.value!,
              width: 1.0,
            ),
            boxShadow: _disabled ? [] : [UbShadow()],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                UbText(
                  widget.title,
                  font: UbFont.body1,
                  textAlign: TextAlign.left,
                  materialColor: fontColorAnimation.value!,
                ),
                const SizedBox(height: 8.0),
                UbAudioButton(
                  controller: _controller,
                  type: widget.type,
                  curve: _curve,

                  // audio
                  url: widget.url,
                  totalDuration: widget.totalDuration,
                  onDisableChanged: (value) {
                    _isDisableChanging = value;
                  },

                  // record
                  disabled: widget.disabled,
                  onFilePathChanged: widget.onFilePathChanged,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
