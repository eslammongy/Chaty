import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField(
      {super.key,
      required this.textEditingController,
      this.hint,
      this.prefix,
      this.autoFocus = false,
      this.textInputType = TextInputType.text,
      this.maxLines = 1,
      this.isTextPassword = false,
      this.textColor,
      this.suffix,
      this.initText,
      this.height = 55.0,
      this.onSubmitted,
      this.onChange,
      this.bkColor,
      this.fieldRoundedRadius,
      this.focusColor,
      this.enabled = true});

  final TextEditingController textEditingController;
  final String? initText;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType textInputType;
  final bool autoFocus;
  final bool? isTextPassword;
  final int? maxLines;
  final Color? textColor;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChange;
  final double height;
  final Color? bkColor;
  final Color? focusColor;
  final BorderRadius? fieldRoundedRadius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: Card(
        color: bkColor ?? theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
            borderRadius: fieldRoundedRadius ?? publicRoundedRadius),
        margin: EdgeInsets.zero,
        elevation: 0,
        child: TextFormField(
          autofocus: autoFocus,
          obscureText: isTextPassword ?? false,
          maxLines: maxLines,
          enabled: enabled,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          controller: textEditingController,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintStyle: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.surfaceTint),
            focusColor: theme.colorScheme.primary,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: focusColor ?? theme.colorScheme.secondary,
                width: 1,
              ),
            ),
            isDense: false,
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(
                bottom: 22, top: 16, left: 10.0, right: 10),
            hintText: hint,
            border: InputBorder.none,
            prefixIcon: prefix,
            suffixIcon: suffix,
            prefixIconColor: textColor ?? theme.colorScheme.surfaceTint,
          ),
          cursorColor: theme.colorScheme.primary,
          keyboardType: textInputType,
          onFieldSubmitted: onSubmitted,
          onChanged: onChange,
        ),
      ),
    );
  }
}
