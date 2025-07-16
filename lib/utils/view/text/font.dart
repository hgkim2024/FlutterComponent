import 'package:flutter/material.dart';

enum UbFont {
  extraTitle,
  title1,
  title2,
  title3,
  subtitle1,
  subtitle2,
  body1,
  body2,
  caption1,
  caption2,
  caption3,
  caption4,
  buttonLarge,
  buttonMiddle,
  buttonSmall,
  inputLarge,
  inputMiddle,
  inputSmall,
  inputCaption;

  TextStyle get style {
    switch (this) {
      case UbFont.extraTitle:
        return _titleStyle.copyWith(
          fontSize: 24,
          letterSpacing: 0,
        );
      case UbFont.title1:
        return _titleStyle.copyWith(
          fontSize: 20,
        );
      case UbFont.title2:
        return _titleStyle.copyWith(
          fontSize: 18,
        );
      case UbFont.title3:
        return _titleStyle.copyWith(
          fontSize: 16,
        );
      case UbFont.subtitle1:
        return _subtitleStyle.copyWith(
          fontSize: 16,
        );
      case UbFont.subtitle2:
        return _subtitleStyle.copyWith(
          fontSize: 14,
        );
      case UbFont.body1:
        return _bodyStyle.copyWith(
          fontSize: 16,
        );
      case UbFont.body2:
        return _bodyStyle.copyWith(
          fontSize: 14,
        );
      case UbFont.caption1:
        return _captionStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
      case UbFont.caption2:
        return _captionStyle.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 10,
        );
      case UbFont.caption3:
        return _captionStyle.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 10,
        );
      case UbFont.caption4:
        return _captionStyle.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 12,
        );
      case UbFont.buttonLarge:
        return _buttonStyle.copyWith(
          fontSize: 18,
          height: 1.25,
        );
      case UbFont.buttonMiddle:
        return _buttonStyle.copyWith(
          fontSize: 16,
          height: 1.2,
        );
      case UbFont.buttonSmall:
        return _buttonStyle.copyWith(
          fontSize: 14,
          height: 1,
        );
      case UbFont.inputLarge:
        return _inputStyle.copyWith(
          fontSize: 18,
        );
      case UbFont.inputMiddle:
        return _inputStyle.copyWith(
          fontSize: 16,
        );
      case UbFont.inputSmall:
        return _inputStyle.copyWith(
          fontSize: 14,
        );
      case UbFont.inputCaption:
        return _inputStyle.copyWith(
          fontSize: 12,
        );
    };
  }

  TextStyle get _titleStyle => const TextStyle(
    fontWeight: FontWeight.w900,
    height: 1.2,
    letterSpacing: -0.02,
  );

  TextStyle get _subtitleStyle => const TextStyle(
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -0.02,
  );

  TextStyle get _bodyStyle => const TextStyle(
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.02,
  );

  TextStyle get _captionStyle => const TextStyle(
    fontSize: 12,
    height: 1.3,
    letterSpacing: 0,
  );

  TextStyle get _buttonStyle => const TextStyle(
    fontWeight: FontWeight.w900,
    letterSpacing: 0,
  );

  TextStyle get _inputStyle => const TextStyle(
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );
}
