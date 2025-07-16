import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ub_flutter/test/screen/test_home_screen.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/log/log.dart';
import 'package:ub_flutter/utils/router/router.dart';

void main() {
  /// Flutter 프레임워크가 실행할 준비가 될때까지 기다린다.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [
        RiverpodObserver(),
      ],
      child: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Pretendard'),
      routerConfig: UbRouter.testRouter,
    );
  }
}
