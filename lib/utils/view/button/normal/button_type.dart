import 'package:ub_flutter/utils/view/color.dart';

enum UbButtonType {
  primary,
  primaryLine,
  grayLine,
  textOnly;

  UbColor getFontColor({
    required UbButtonState state,
  }) {
    switch (this) {
      case UbButtonType.primary:
        return UbColor.white;

      case UbButtonType.primaryLine:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.primaryNormal;
          case UbButtonState.disabled:
            return UbColor.primaryAlternative;
          case UbButtonState.pressed:
            return UbColor.primarySupport;
        }

      case UbButtonType.grayLine:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.textStrong;
          case UbButtonState.disabled:
            return UbColor.disabledLight;
          case UbButtonState.pressed:
            return UbColor.textSupport;
        }

      case UbButtonType.textOnly:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.primaryNormal;
          case UbButtonState.disabled:
            return UbColor.textCaption;
          case UbButtonState.pressed:
            return UbColor.primarySupport;
        }
    }
  }

  UbColor getBgColor({
    required UbButtonState state,
  }) {
    switch (this) {
      case UbButtonType.primary:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.primaryNormal;
          case UbButtonState.disabled:
            return UbColor.primaryAlternative;
          case UbButtonState.pressed:
            return UbColor.primarySupport;
        }

      case UbButtonType.primaryLine:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.white;
          case UbButtonState.disabled:
            return UbColor.white;
          case UbButtonState.pressed:
            return UbColor.primaryBackground;
        }

      case UbButtonType.grayLine:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.white;
          case UbButtonState.disabled:
            return UbColor.white;
          case UbButtonState.pressed:
            return UbColor.disabledLight;
        }

      case UbButtonType.textOnly:
        return UbColor.clear;
    }
  }

  UbColor getBorderColor({
    required UbButtonState state,
  }) {
    switch (this) {
      case UbButtonType.primary:
        return UbColor.clear;

      case UbButtonType.primaryLine:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.primaryNormal;
          case UbButtonState.disabled:
            return UbColor.primaryAlternative;
          case UbButtonState.pressed:
            return UbColor.primarySupport;
        }

      case UbButtonType.grayLine:
        switch (state) {
          case UbButtonState.idle:
            return UbColor.textStrong;
          case UbButtonState.disabled:
            return UbColor.disabledLight;
          case UbButtonState.pressed:
            return UbColor.textSupport;
        }

      case UbButtonType.textOnly:
        return UbColor.clear;
    }
  }
}

enum UbButtonState {
  idle,
  disabled,
  pressed;
}
