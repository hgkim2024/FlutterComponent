import 'package:flutter/cupertino.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';
import '../../../utils/data.dart';
import '../../../utils/log/log.dart';
import '../../../utils/view/button/normal/button.dart';
import '../../../utils/view/button/normal/button_icon.dart';
import '../../../utils/view/button/normal/button_size.dart';
import '../../../utils/view/button/normal/button_type.dart';

class TestButtonScreen extends StatefulWidget {
  const TestButtonScreen({super.key});

  @override
  State<TestButtonScreen> createState() => _TestButtonScreenState();
}

class _TestButtonScreenState extends State<TestButtonScreen> {
  VoidCallback? _onPressed = null;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Button',
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'large',
                  size: UbButtonSize.large,
                  type: UbButtonType.primary,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'middle',
                  size: UbButtonSize.middle,
                  type: UbButtonType.primary,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'small',
                  size: UbButtonSize.small,
                  type: UbButtonType.primary,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'large',
                  size: UbButtonSize.large,
                  type: UbButtonType.primaryLine,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'middle',
                  size: UbButtonSize.middle,
                  type: UbButtonType.primaryLine,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'small',
                  size: UbButtonSize.small,
                  type: UbButtonType.primaryLine,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'large',
                  size: UbButtonSize.large,
                  type: UbButtonType.grayLine,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'middle',
                  size: UbButtonSize.middle,
                  type: UbButtonType.grayLine,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'small',
                  size: UbButtonSize.small,
                  type: UbButtonType.grayLine,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'large',
                  size: UbButtonSize.large,
                  type: UbButtonType.textOnly,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'middle',
                  size: UbButtonSize.middle,
                  type: UbButtonType.textOnly,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: 'small',
                  size: UbButtonSize.small,
                  type: UbButtonType.textOnly,
                  onPressed: _onPressed,
                  icon: UbButtonIcon.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: UbButton(
                  title: _onPressed == null ? 'active all' : 'disable all',
                  size: UbButtonSize.large,
                  type: UbButtonType.primary,
                  onPressed: () {
                    setState(() {
                      if (_onPressed == null) {
                        _onPressed = () {
                          ubLog.tag(Tag.SCREEN).d('onPressed');
                          setState(() {

                          });
                        };
                      } else {
                        _onPressed = null;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
