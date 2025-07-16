
/*
tap down duration : tap up duration = 2 : 1
animation duration = tap down duration + tap up duration
 */
const Duration tapForwardAnimationDuration = Duration(milliseconds: 140);
const Duration tapReverseAnimationDuration = Duration(milliseconds: 70);
const Duration animationDuration = Duration(milliseconds: 210);

const double scaleBegin = 1.0;
const double scaleEnd = 0.96;

const int _shortThrottleTime = 300;
const int _longThrottleTime = 1000;

enum UbButtonThrottle {
  short,
  long;

  Duration get duration {
    switch (this) {
      case UbButtonThrottle.short:
        return const Duration(milliseconds: _shortThrottleTime);
      case UbButtonThrottle.long:
        return const Duration(milliseconds: _longThrottleTime);
    }
  }

  int get time {
    switch (this) {
      case UbButtonThrottle.short:
        return _shortThrottleTime;
      case UbButtonThrottle.long:
        return _longThrottleTime;
    }
  }
}