import 'package:ub_flutter/utils/view/text/font.dart';

enum UbButtonSize {
  large,
  middle,
  small;

  double get radius {
    // switch (this) {
    //   case UbButtonSize.large:
    //     return 8;
    //   case UbButtonSize.middle:
    //     return 6;
    //   case UbButtonSize.small:
    //     return 4;
    // }
    return height/2;
  }

  double get height {
    switch (this) {
      case UbButtonSize.large:
        return 52;
      case UbButtonSize.middle:
        return 44;
      case UbButtonSize.small:
        return 32;
    }
  }

  double get iconHeight {
    switch (this) {
      case UbButtonSize.large:
        return 23;
      case UbButtonSize.middle:
        return 19;
      case UbButtonSize.small:
        return 15;
    }
  }

  UbFont get font {
    switch (this) {
      case UbButtonSize.large:
        return UbFont.buttonLarge;
      case UbButtonSize.middle:
        return UbFont.buttonMiddle;
      case UbButtonSize.small:
        return UbFont.buttonSmall;
    }
  }
}