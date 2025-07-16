import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ub_flutter/utils/view/image.dart';

import '../color.dart';
import 'font.dart';

class UbTextFormField extends StatelessWidget {
  final UbFont font;
  final String? initialValue;
  final bool enabled;
  final bool expand;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool useUnderline;
  final UbImage? icon;

  const UbTextFormField({
    super.key,
    this.font = UbFont.inputSmall,
    this.initialValue,
    this.enabled = true,
    this.expand = false,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.useUnderline = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return expand
        ? Expanded(
            child: renderTextFormField(context),
          )
        : renderTextFormField(context);
  }

  renderTextFormField(BuildContext context) {
    const double borderWidth = 1.0;
    double radius = font == UbFont.inputLarge ? 6.0 : 4.0;

    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: UbColor.disabled.color,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );

    // underline 스타일 정의
    final underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: UbColor.disabled.color,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );

    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      onSaved: enabled ? onSaved : null,
      validator: enabled ? validator : null,
      maxLines: !useUnderline && expand ? null : 1,
      minLines: !useUnderline && expand ? null : 1,
      expands: !useUnderline && expand,
      textAlignVertical: !useUnderline && expand
          ? TextAlignVertical.top
          : TextAlignVertical.center,
      cursorColor: UbColor.textStrong.color,
      style: font.style.copyWith(
        color: enabled
            ? (FocusScope.of(context).hasFocus
                ? UbColor.textStrong.color // Focused color
                : UbColor.textStrong.color) // Enabled but not focused
            : UbColor.disabled.color, // Disabled color,
      ),
      cursorErrorColor: UbColor.red.color,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: !useUnderline && expand ? 8 : 14,
          vertical: !useUnderline && expand ? 8 : 10,
        ),
        hintText: hintText,
        isDense: true,
        errorText: errorText,
        errorStyle: font.style.copyWith(
          color: UbColor.red.color,
        ),
        hintStyle: font.style.copyWith(
          color: UbColor.disabled.color,
        ),
        fillColor: enabled
            ? (FocusScope.of(context).hasFocus
                ? UbColor.white.color // Focused color
                : UbColor.white.color) // Enabled but not focused
            : UbColor.disabledLight.color,
        filled: true,
        suffixIcon: icon != null
            ? UbSvgImage(
                image: icon!,
                width: 24,
                height: 24,
                fit: BoxFit.none,
              )
            : null,

        border: useUnderline ? underlineBorder : baseBorder,
        enabledBorder: useUnderline ? underlineBorder : baseBorder,
        disabledBorder: useUnderline
            ? underlineBorder.copyWith(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              )
            : baseBorder,
        focusedBorder: useUnderline
            ? underlineBorder.copyWith(
                borderSide: underlineBorder.borderSide.copyWith(
                  color: UbColor.primaryNormal.color,
                ),
              )
            : baseBorder.copyWith(
                borderSide: baseBorder.borderSide.copyWith(
                  color: UbColor.primaryNormal.color,
                ),
              ),
        errorBorder: useUnderline
            ? underlineBorder.copyWith(
                borderSide: underlineBorder.borderSide.copyWith(
                  color: UbColor.red.color,
                ),
              )
            : baseBorder.copyWith(
                borderSide: baseBorder.borderSide.copyWith(
                  color: UbColor.red.color,
                ),
              ),
      ),
    );
  }
}
