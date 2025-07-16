import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/test/screen/test_home_screen.dart';
import 'package:ub_flutter/utils/dialog/input_dialog.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/view/button/normal/button.dart';
import 'package:ub_flutter/utils/dialog/dialog.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

class TestDialogScreen extends StatelessWidget {
  const TestDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'dialog',
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                UbText(
                  '일반 Dialog',
                  font: UbFont.title3,
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'title only',
                  onPressed: () {
                    UbDialog.show(
                      context: context,
                      title: '안녕하세요!',
                    );
                  },
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'content only',
                  onPressed: () {
                    UbDialog.show(
                      context: context,
                      content:
                          'Flutter 개발을 하다 보면 너무 편해서 다른 언어 못 돌아갈 것 같은 느낌이 듭니다.',
                    );
                  },
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'title and content',
                  onPressed: () {
                    UbDialog.show(
                      context: context,
                      title: '안녕하세요!',
                      content:
                          'AOS, iOS 네이티브 개발을 위주로 개발하고 있는 김현구 입니다.',
                    );
                  },
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'cancel on',
                  onPressed: () {
                    UbDialog.show(
                        context: context,
                        highlightText: UbHighlightText(
                          text:
                              '정말 삭제하시겠습니까?',
                          highlightTexts: ['삭제'],
                        ),
                        confirmTitle: '삭제',
                        cancelTitle: '취소');
                  },
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'all',
                  onPressed: () {
                    UbDialog.show(
                      context: context,
                      title: '반복 일정 삭제',
                      highlightText: UbHighlightText(
                        text: '반복 일정을 삭제하시겠습니까?',
                        highlightTexts: ['반복 일정'],
                      ),
                      confirmTitle: '이 일정만 삭제',
                      onConfirmPressed: () {
                        context.pop();
                      },
                      cancelTitle: '이후 일정 모두 삭제',
                      onCancelPressed: () {
                        context.pop();
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                UbText(
                  '입력 Dialog',
                  font: UbFont.title3,
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'input',
                  onPressed: () {
                    UbInputDialog.show(
                        context: context,
                        title: '이름을 입력해주세요.',
                        hint: '이름 입력',
                        onConfirmPressed: (value) {
                          context.pop();
                        });
                  },
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'input error/validate',
                  onPressed: () {
                    UbInputDialog.show(
                        context: context,
                        title: '이름을 입력해주세요.',
                        hint: '이름 입력',
                        errorText: 'Error',
                        onConfirmPressed: (value) {
                          context.pop();
                        });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
