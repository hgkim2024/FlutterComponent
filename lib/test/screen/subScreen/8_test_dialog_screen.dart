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
                      title: '어제의 갈망감 수준이 기록되었어요!',
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
                          '갈망감을 기록하면 그동안의 변화를 쉽게 파악할 수 있어요 뿐만 아니라 내가 언제 유혹을 심하게 느꼈는지, 단약을 유지하려면 어떤 노력이 필요할 지에 대해서도 힌트를 얻을 수 있답니다.',
                    );
                  },
                ),
                const SizedBox(height: 16),
                UbButton(
                  title: 'title and content',
                  onPressed: () {
                    UbDialog.show(
                      context: context,
                      title: '어제의 갈망감 수준이 기록되었어요!',
                      content:
                          '갈망감을 기록하면 그동안의 변화를 쉽게 파악할 수 있어요 뿐만 아니라 내가 언제 유혹을 심하게 느꼈는지, 단약을 유지하려면 어떤 노력이 필요할 지에 대해서도 힌트를 얻을 수 있답니다.',
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
                              '어제 “약간 강함” 수준의 갈망감을 느끼셨던 기록이 있어요.\n\n다시 체크해보실래요?',
                          highlightTexts: ['“약간 강함”'],
                        ),
                        confirmTitle: '그냥 넘어가기',
                        cancelTitle: '다시 체크하기');
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
                        title: '지금 어떤 감정을 느끼고 계신가요?',
                        hint: '직접 작성하세요.',
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
                        title: '지금 어떤 감정을 느끼고 계신가요?',
                        hint: '직접 작성하세요.',
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
