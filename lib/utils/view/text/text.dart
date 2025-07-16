import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/data.dart';

import '../../log/log.dart';
import '../color.dart';
import 'font.dart';

class UbText extends StatelessWidget {
  final String title;
  final UbFont font;
  final UbColor color;
  final Color? materialColor;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final UbColor? selectionColor;

  const UbText(
    this.title, {
    super.key,
    required this.font,
    this.color = UbColor.textNormal,
    this.materialColor,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: font.style.copyWith(
          color: materialColor == null ? color.color : materialColor!),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectionColor: selectionColor?.color,
    );
  }
}

class UbHighlightText extends StatelessWidget {
  final String text;
  final List<String>? highlightTexts;
  final List<UbColor>? highlightColors;
  final List<UbFont>? highlightFonts;
  final UbFont font;
  final UbColor fontColor;
  final TextAlign textAlign;

  const UbHighlightText({
    super.key,
    required this.text,
    this.highlightTexts,
    this.highlightColors,
    this.highlightFonts,
    this.font = UbFont.body2,
    this.fontColor = UbColor.textAlternative,
    this.textAlign = TextAlign.center,
  });

  TextStyle get fontStyle {
    return font.style.copyWith(
      color: fontColor.color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final highlightTexts = this.highlightTexts ?? [];

    // 텍스트를 동적으로 하이라이트 처리
    final spans = _buildHighlightedTextSpans(text, highlightTexts);

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: spans,
        style: fontStyle,
      ),
    );
  }

  List<TextSpan> _buildHighlightedTextSpans(
      String text, List<String> highlights) {
    final spans = <TextSpan>[];
    String remainingText = text;

    // 하이라이트 단어 처리
    while (remainingText.isNotEmpty) {
      int matchIndex = -1;
      String? matchedHighlight;

      for (final highlight in highlights) {
        final index = remainingText.indexOf(highlight);

        if (index != -1 && (matchIndex == -1 || index < matchIndex)) {
          matchIndex = index;
          matchedHighlight = highlight;
        }
      }

      if (matchIndex == -1) {
        // 남아 있는 텍스트에 더 이상 하이라이트 단어가 없으면 추가하고 종료
        spans.add(
          TextSpan(
            text: remainingText,
            style: fontStyle,
          ),
        );
        break;
      }

      if (matchIndex > 0) {
        // 매치되기 전까지의 텍스트를 일반 텍스트로 추가
        spans.add(
          TextSpan(
            text: remainingText.substring(0, matchIndex),
            style: fontStyle,
          ),
        );
      }

      // 매치된 단어를 하이라이트 처리하여 추가
      // ubLog.tag(Tag.SCREEN).d('text: $matchedHighlight');
      final index = highlights.indexWhere((e) => e == matchedHighlight);
      spans.add(
        TextSpan(
          text: matchedHighlight,
          style: getHighlightFont(index).style.copyWith(
                color: getHighlightColor(index).color,
              ),
        ),
      );

      // 처리된 부분을 잘라서 다음 루프로 진행
      remainingText =
          remainingText.substring(matchIndex + matchedHighlight!.length);
    }

    return spans;
  }

  UbFont getHighlightFont(int index) {
    if (highlightFonts == null || highlightFonts!.isEmpty) {
      return font;
    }

    // ubLog.tag(Tag.SCREEN).d('index: $index');

    if (index < highlightFonts!.length) {
      return highlightFonts![index];
    } else {
      return font;
    }
  }

  UbColor getHighlightColor(int index) {
    if (highlightColors == null || highlightColors!.isEmpty) {
      return UbColor.primaryNormal;
    }

    // ubLog.tag(Tag.SCREEN).d('index: $index');

    if (index < highlightColors!.length) {
      return highlightColors![index];
    } else {
      return UbColor.primaryNormal;
    }
  }
}
