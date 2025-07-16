import 'package:collection/collection.dart';

enum UbHttpCode {
  OK,
  SYSTEM_ERROR,
  BAD_REQUEST_DATA,
  BAD_REQEUST_INPUT,
  LOGIN_ERROR,
  EXPIRED_TOKEN,
  EXPIRED_AUTHENTICATION,
  EXPIRED_ACCOUNT,
  NONE;

  String get code {
    switch (this) {
      case UbHttpCode.OK:
        return '00000';
      case UbHttpCode.SYSTEM_ERROR:
        return '99999';

      case UbHttpCode.BAD_REQUEST_DATA:
        return '10000';
      case UbHttpCode.BAD_REQEUST_INPUT:
        return '30000';

      case UbHttpCode.LOGIN_ERROR:
        return '90000';
      case UbHttpCode.EXPIRED_TOKEN:
        return '90010';
      case UbHttpCode.EXPIRED_AUTHENTICATION:
        return '90020';
      case UbHttpCode.EXPIRED_ACCOUNT:
        return '90030';

      case UbHttpCode.NONE:
        return 'none';
    }
  }

  static UbHttpCode fromString(String string) {
    final first = UbHttpCode.values.firstWhereOrNull((e) => e.code == string);
    return first ?? UbHttpCode.NONE;
  }
}
