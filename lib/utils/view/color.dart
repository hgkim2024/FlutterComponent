import 'package:flutter/material.dart';

enum UbColor {
  // MARK: - Primary
  primaryNormal,
  primarySupport,
  primaryAlternative,
  primaryAssistive,
  primaryBackground,

  // MARK: - Text
  textStrong,
  textNormal,
  textSupport,
  textAlternative,
  textAssistive,
  textCaption,

  // MARK: - UI
  blue,
  blueLight,
  red,
  redLight,
  orange,
  orangeLight,
  yellow,
  yellowLight,
  green,
  greenLight,
  purple,
  purpleLight,
  gray,
  black,
  white,
  disabled,
  disabledLight,

  // MARK: - Background
  backgroundNormal,
  backgroundAssistive,
  backgroundDimmed,
  backgroundLightDimmed,
  videoDimmed,

  // MARK: - Line
  lineOnWhite,
  lineOnColor,
  shadow,
  clear;

  Color get color {
    switch (this) {
      case UbColor.primaryNormal:
        return const Color(0xFF2A81B7);
      case UbColor.primarySupport:
        return const Color(0xFF37197D);
      case UbColor.primaryAlternative:
        return const Color(0xFFC4E9F5);
      case UbColor.primaryAssistive:
        return const Color(0xFFEEF9FB);
      case UbColor.primaryBackground:
        return const Color(0xFFEEFBFB);

      case UbColor.textStrong:
        return const Color(0xFF101219);
      case UbColor.textNormal:
        return const Color(0xFF2E3142);
      case UbColor.textSupport:
        return const Color(0xFF535968);
      case UbColor.textAlternative:
        return const Color(0xFF787E8B);
      case UbColor.textAssistive:
        return const Color(0xFF9AA1AB);
      case UbColor.textCaption:
        return const Color(0xFFC4C7CE);

      case UbColor.blue:
        return const Color(0xFF3181F5);
      case UbColor.blueLight:
        return const Color(0xFFEFF8FF);
      case UbColor.red:
        return const Color(0xFFF86754);
      case UbColor.redLight:
        return const Color(0xFFFEF0EE);
      case UbColor.orange:
        return const Color(0xFFFB9E7D);
      case UbColor.orangeLight:
        return const Color(0xFFFEEFE8);
      case UbColor.yellow:
        return const Color(0xFFFFBB1E);
      case UbColor.yellowLight:
        return const Color(0xFFFFFADD);
      case UbColor.green:
        return const Color(0xFF2BC96B);
      case UbColor.greenLight:
        return const Color(0xFFEDFCF4);
      case UbColor.purple:
        return const Color(0xFF7F5CEB);
      case UbColor.purpleLight:
        return const Color(0xFFF4F2FE);
      case UbColor.gray:
        return const Color(0xFFEDF0F4);
      case UbColor.black:
        return const Color(0xFF000000);
      case UbColor.white:
        return const Color(0xFFFFFFFF);

      case UbColor.disabled:
        return const Color(0xFFBDBDBD);
      case UbColor.disabledLight:
        return const Color(0xFFE8E8EB);

      case UbColor.backgroundNormal:
        return const Color(0xFFFFFFFF);
      case UbColor.backgroundAssistive:
        return const Color(0xFFF5F9FB);
      case UbColor.backgroundDimmed:
        return const Color(0xB2344854);
      case UbColor.backgroundLightDimmed:
        return const Color(0x20000000);
      case UbColor.videoDimmed:
        return const Color.fromRGBO(50, 50, 50, 0.4);

      case UbColor.lineOnWhite:
        return const Color(0xFFE8E9ED);
      case UbColor.lineOnColor:
        return const Color(0xFFE3EDEE);
      case UbColor.shadow:
        return const Color.fromRGBO(0, 0, 0, 0.08);
      case UbColor.clear:
        return const Color(0x00000000);
    }
  }
}

enum UbGradientColor {
  primaryGradient,
  thumbnailGradient,
  slider;

  LinearGradient get gradient {
    switch (this) {
      case UbGradientColor.primaryGradient:
        return const LinearGradient(colors: [
          Color(0xFF26A6CC),
          Color(0xFF37197D),
        ]);
      case UbGradientColor.thumbnailGradient:
        return const LinearGradient(
          colors: [
            Color(0x00686868),
            Color(0x88282c2f),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 1],
        );
      case UbGradientColor.slider:
        return LinearGradient(
          colors: const [
            Color(0xFF371A7E),
            Color(0xFF2E60A5),
            Color(0xFF6989C4),
            Color(0xFFE098DB),
            Color(0xFFFB999D),
            Color(0xFFFFB888),
            Color(0xFFFFDF96),
          ],
          stops: List.generate(7, (index) => 1.0 / 7.0 * index),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
    }
  }
}

class UbShadow extends BoxShadow {
  UbShadow(): super(
    color: UbColor.shadow.color,
    offset: const Offset(2.0, 2.0),
    blurRadius: 12.0,
    spreadRadius: 0,
  );
}
