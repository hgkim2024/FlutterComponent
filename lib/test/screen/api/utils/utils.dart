import 'package:flutter/cupertino.dart';

import '../../../../utils/view/button/normal/button_animation_data.dart';

class DataUtils {
  static final baseUrl = 'https://dstop.ubi-plus.co.kr/api/v1';

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }

  static double getPortraitMaxWidth(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;

    return width;
  }
}

enum CMPType {
  CMP,
  NCMP;

  static CMPType fromString(String string) {
    return string.toUpperCase() == CMP.name.toUpperCase()
        ? CMPType.CMP
        : CMPType.NCMP;
  }
}
