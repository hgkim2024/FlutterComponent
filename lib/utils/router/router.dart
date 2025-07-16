import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';
import 'package:ub_flutter/test/screen/subScreen/10_test_audio_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/2_test_button_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/4_test_checkbox_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/6_test_radio_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/3_test_slider_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/5_test_switch_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/7_test_text_form_field_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/8_test_dialog_screen.dart';
import 'package:ub_flutter/test/screen/subScreen/9_test_video_screen.dart';
import 'package:ub_flutter/test/screen/test_home_screen.dart';
import 'package:ub_flutter/utils/view/button/video/video_player_screen.dart';
import 'package:video_player/video_player.dart';

import '../../test/screen/subScreen/1_test_text_screen.dart';

class UbRouter {
  static GoRouter testRouter = GoRouter(
    routes: routes,
    initialLocation: UbTestRoute.initPath,
    debugLogDiagnostics: true,
  );

  static List<GoRoute> get routes => [
        GoRoute(
          path: UbTestRoute.initPath,
          name: UbTestRoute.home.name,
          builder: UbTestRoute.home.builder,
          routes: [
            UbTestRoute.text._route,
            UbTestRoute.button._route,
            UbTestRoute.slider._route,
            UbTestRoute.checkbox._route,
            UbTestRoute.toggle._route,
            UbTestRoute.radio._route,
            UbTestRoute.textFormField._route,
            UbTestRoute.dialog._route,
            UbTestRoute.video._route,
            UbTestRoute.videoPlayer._route,
            UbTestRoute.audio._route,
          ],
        ),
      ];
}

enum UbTestRoute {
  home,
  text,
  button,
  slider,
  checkbox,
  toggle,
  radio,
  textFormField,
  dialog,
  video,
  videoPlayer,
  audio;

  static List<UbTestRoute> get testValues => [
        text,
        button,
        slider,
        checkbox,
        toggle,
        radio,
        textFormField,
        dialog,
        // video,
        // audio
      ];

  GoRouterWidgetBuilder? get builder {
    return (context, state) {
      switch (this) {
        case UbTestRoute.home:
          return const TestHomeScreen();
        case UbTestRoute.text:
          return const TestTextScreen();
        case UbTestRoute.button:
          return const TestButtonScreen();
        case UbTestRoute.slider:
          return const TestSliderScreen();
        case UbTestRoute.checkbox:
          return const TestCheckboxScreen();
        case UbTestRoute.toggle:
          return const TestSwitchScreen();
        case UbTestRoute.radio:
          return const TestRadioScreen();
        case UbTestRoute.textFormField:
          return TestTextFormFieldSceen();
        case UbTestRoute.dialog:
          return const TestDialogScreen();
        case UbTestRoute.video:
          return const TestVideoScreen();
        case UbTestRoute.videoPlayer:
          return UbVideoPlayerScreen(videoModel: state.extra as VideoModel);
        case UbTestRoute.audio:
          return const TestAudioScreen();
      }
    };
  }

  GoRoute get _route {
    return GoRoute(
      path: name,
      name: name,
      builder: builder,
    );
  }

  static String get initPath {
    return '/${UbTestRoute.home.name}';
  }
}
