import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:record/record.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/dialog/dialog.dart';
import 'package:ub_flutter/utils/log/log.dart';
import 'package:ub_flutter/utils/view/image.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../button/normal/button_animation_data.dart';
import 'package:just_audio/just_audio.dart';
import '../color.dart';
import 'package:path_provider/path_provider.dart';

enum UbAudioType {
  play,
  record;
}

class UbAudioButton extends StatefulWidget {
  final AnimationController controller;
  final UbAudioType type;
  final UbButtonThrottle throttle;
  final Cubic curve;

  // audio
  final String? url;
  final ValueChanged<bool>? onDisableChanged;
  final Duration totalDuration;

  // record
  final bool disabled;
  final ValueChanged<String>? onFilePathChanged;

  const UbAudioButton({
    super.key,
    required this.controller,
    required this.type,
    this.throttle = UbButtonThrottle.long,
    this.curve = Curves.easeInOut,

    // audio
    this.url,
    this.onDisableChanged,
    this.totalDuration = Duration.zero,

    // record
    this.disabled = false,
    this.onFilePathChanged,
  });

  @override
  State<UbAudioButton> createState() => _UbAudioButtonState();
}

class _UbAudioButtonState extends State<UbAudioButton> {
  bool _isDisableChanging = true;
  late AudioPlayer? _player;

  late AudioRecorder? _recorder;
  bool _isRecording = false;
  String? _filePath;
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  late Animation<Color?> _bgColorAnimation;
  late Animation<Color?> _disabledBgColorAnimation;
  final UbColor _idleBgColor = UbColor.primaryAssistive;
  final UbColor _disabledBgColor = UbColor.disabledLight;
  final UbColor _pressedBgColor = UbColor.primaryNormal;

  late Animation<Color?> _borderColorAnimation;
  late Animation<Color?> _disabledBorderColorAnimation;
  final UbColor _idleBorderColor = UbColor.primaryAlternative;
  final UbColor _disabledBorderColor = UbColor.clear;
  final UbColor _pressedBorderColor = UbColor.clear;

  late Animation<Color?> _fontColorAnimation;
  late Animation<Color?> _disabledFontColorAnimation;
  final UbColor _idleFontColor = UbColor.textNormal;
  final UbColor _disabledFontColor = UbColor.textCaption;
  final UbColor _pressedFontColor = UbColor.white;

  late Animation<Color?> _iconColorAnimation;
  late Animation<Color?> _disabledIconColorAnimation;
  final UbColor _idleIconColor = UbColor.black;
  final UbColor _disabledIconColor = UbColor.disabled;
  final UbColor _pressedIconColor = UbColor.white;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case UbAudioType.play:
        _player = AudioPlayer();
        _setAudioUrl(url: widget.url);
        _player!.playerStateStream.listen((state) {
          ubLog.tag(Tag.AUDIO).d(
              'playing - ${_player!.playing}, status - ${state.processingState}');
          if (_player!.playing &&
              state.processingState == ProcessingState.completed) {
            _stopAudio();
          }
        });
      case UbAudioType.record:
        _recorder = AudioRecorder();
    }

    widget.onDisableChanged?.call(_isDisableChanging);

    _bgColorAnimation = ColorTween(
      begin: _idleBgColor.color,
      end: _pressedBgColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _disabledBgColorAnimation = ColorTween(
      begin: _idleBgColor.color,
      end: _disabledBgColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _borderColorAnimation = ColorTween(
      begin: _idleBorderColor.color,
      end: _pressedBorderColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _disabledBorderColorAnimation = ColorTween(
      begin: _idleBorderColor.color,
      end: _disabledBorderColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _fontColorAnimation = ColorTween(
      begin: _idleFontColor.color,
      end: _pressedFontColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );
    _disabledFontColorAnimation = ColorTween(
      begin: _idleFontColor.color,
      end: _disabledFontColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    _iconColorAnimation = ColorTween(
      begin: _idleIconColor.color,
      end: _pressedIconColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );
    _disabledIconColorAnimation = ColorTween(
      begin: _idleIconColor.color,
      end: _disabledIconColor.color,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    if (_disabled) {
      widget.controller.forward();
    }
  }

  @override
  void dispose() {
    switch (widget.type) {
      case UbAudioType.play:
        _player!.stop();
        _player!.dispose();
      case UbAudioType.record:
        _recorder!.stop();
        _recorder!.dispose();
        _timer?.cancel();
    }

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

  @override
  void didUpdateWidget(covariant UbAudioButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((widget.url == null && oldWidget.url != null) ||
        (widget.url != null && oldWidget.url == null) ||
        (widget.disabled != oldWidget.disabled)) {
      // ubLog.tag(Tag.SCREEN).d(
      //       'didUpdateWidget url - ${widget.url}, old url - ${oldWidget.url}',
      //     );
      // ubLog.tag(Tag.SCREEN).d(
      //   'didUpdateWidget disabled - ${widget.disabled}, old disabled - ${oldWidget.disabled}',
      // );
      _onPressedChanged();
    } else if (widget.url != null &&
        oldWidget.url != null &&
        widget.url != oldWidget.url) {
      switch (widget.type) {
        case UbAudioType.play:
          _setAudioUrl(url: widget.url);
        case UbAudioType.record:
          break;
      }
    }
  }

  _onPressedChanged() async {
    // ubLog.tag(Tag.SCREEN).xd('onChangedDisableStatus');

    _isDisableChanging = true;
    widget.onDisableChanged?.call(_isDisableChanging);
    // ubLog.tag(Tag.SCREEN).xd('widget.controller.status - ${widget.controller.status}');

    if (_disabled) {
      widget.controller.duration = animationDuration;
      widget.controller.forward();
    } else {
      switch (widget.type) {
        case UbAudioType.play:
          _setAudioUrl(url: widget.url);
        case UbAudioType.record:
          break;
      }
      widget.controller.duration = animationDuration;
      widget.controller.reverse();
    }
  }

  void _onTapUp(TapUpDetails details) async {
    if (_disabled) return;

    _isDisableChanging = false;
    widget.onDisableChanged?.call(_isDisableChanging);

    switch (widget.type) {
      case UbAudioType.play:
        if (!_player!.playing) {
          ubLog.tag(Tag.AUDIO).d('play');
          widget.controller.duration = animationDuration;
          widget.controller.forward();
          try {
            await _player!.play();
          } catch (e) {
            ubLog.tag(Tag.AUDIO).d('play exception - $e');
            _stopAudio();
          }
        } else {
          ubLog.tag(Tag.AUDIO).d('pause');
          _player!.pause();
          widget.controller.duration = animationDuration;
          widget.controller.reverse();
        }
      case UbAudioType.record:
        if (await _recorder!.hasPermission()) {
          _onTapRecord();
        } else {
          var status = await Permission.microphone.request();
          switch (status) {
            case PermissionStatus.granted:
              _onTapRecord();
            case PermissionStatus.restricted:
            case PermissionStatus.limited:
            case PermissionStatus.permanentlyDenied:
              UbDialog.show(
                  context: context,
                  content: '마이크 권한을 허용하셔야 이용 가능합니다. 권한 설정화면으로 이동하시겠습니까?',
                  cancelTitle: '취소',
                  onConfirmPressed: () {
                    _openAppSettings(context);
                  });
            default:
              Permission.microphone.request();
          }
        }
    }
  }

  Future<void> _openAppSettings(BuildContext context) async {
    bool opened = await openAppSettings();
    if (!opened) {
      // TODO: 예외 메세지 던지기
    }
  }

  _onTapRecord() async {
    if (await _recorder!.isRecording()) {
      ubLog.tag(Tag.AUDIO).d('stop record');
      _isRecording = false;
      _recorder!.stop();
      widget.onFilePathChanged?.call(_filePath!);
      widget.controller.duration = animationDuration;
      widget.controller.reverse();
      _timer?.cancel();
    } else {
      ubLog.tag(Tag.AUDIO).d('start record');
      _isRecording = true;
      final directory = await getTemporaryDirectory();
      _filePath =
          '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      _recorder!.start(const RecordConfig(), path: _filePath!);
      widget.controller.duration = animationDuration;
      widget.controller.forward();

      _elapsedTime = Duration.zero;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime = _elapsedTime + const Duration(seconds: 1);
        });
      });
    }
  }

  _setAudioUrl({String? url}) async {
    if (url != null) {
      final directory = await getTemporaryDirectory();
      if (url.contains(directory.path)) {
        await _player!.setFilePath(url);
      } else {
        await _player!.setUrl(url);
      }
      ubLog.tag(Tag.AUDIO).d('set audio url - $url');
    }
    _stopAudio();
  }

  _stopAudio() {
    ubLog.tag(Tag.AUDIO).d('_stopAudio');
    _player!.stop();
    _player!.seek(Duration.zero);
    widget.controller.duration = animationDuration;
    widget.controller.reverse();
  }

  UbImage get icon {
    switch (widget.type) {
      case UbAudioType.play:
        return _disabled
            ? UbImage.audio_play_disabled
            : _player!.playing
                ? UbImage.audio_stop
                : UbImage.audio_play;
      case UbAudioType.record:
        return _disabled
            ? UbImage.audio_record_disabled
            : _isRecording
                ? UbImage.audio_stop
                : UbImage.audio_record;
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

  Animation<Color?> get iconColorAnimation {
    return _disabled || _isDisableChanging
        ? _disabledIconColorAnimation
        : _iconColorAnimation;
  }

  Animation<Color?> get fontColorAnimation {
    return _disabled || _isDisableChanging
        ? _disabledFontColorAnimation
        : _fontColorAnimation;
  }

  String formatDuration(Duration position) {
    final minutes = position.inMinutes;
    final seconds = position.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // ubLog.tag(Tag.AUDIO).d('build');
    const double height = 48.0;
    const double gap = 8.0;
    return GestureDetector(
      onTapUp: _onTapUp,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          // ubLog.tag(Tag.AUDIO).d(
          //     '_player!.processingState - ${_player!.processingState}');
          return Container(
            height: height,
            decoration: BoxDecoration(
              color: bgColorAnimation.value!,
              borderRadius: BorderRadius.circular(height / 2),
              border: Border.all(
                color: borderColorAnimation.value!,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: gap),
                UbSvgImage(
                  image: icon,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: gap),
                Expanded(
                  child: UbSvgImage(
                    image: UbImage.audio_waveform,
                    width: 122,
                    height: 32,
                    materialColor: iconColorAnimation.value!,
                  ),
                ),
                const SizedBox(width: gap),
                if (widget.type == UbAudioType.play)
                  StreamBuilder(
                    stream: _player!.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data;
                      if (!(_player!.playing ||
                              _player!.processingState ==
                                  ProcessingState.ready) ||
                          _player!.position == Duration.zero) {
                        position = widget.totalDuration;
                      }

                      return UbText(
                        formatDuration(position!),
                        font: UbFont.body2,
                        materialColor: fontColorAnimation.value!,
                      );
                    },
                  ),
                if (widget.type == UbAudioType.record)
                  UbText(
                    formatDuration(_elapsedTime),
                    font: UbFont.body2,
                    materialColor: fontColorAnimation.value!,
                  ),
                const SizedBox(width: gap),
              ],
            ),
          );
        },
      ),
    );
  }
}
