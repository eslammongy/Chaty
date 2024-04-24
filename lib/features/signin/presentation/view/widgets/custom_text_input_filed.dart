import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/utils/helper.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    Key? key,
    required this.textEditingController,
    this.hint,
    this.prefix,
    this.autoFocus = false,
    this.textInputType = TextInputType.text,
    this.onSaved,
    this.maxLines = 1,
    this.isTextPassword = false,
    this.textColor,
    this.suffix,
    this.initText,
    this.height = 55.0,
  }) : super(key: key);

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
  final Function(String?)? onSaved;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    textEditingController.text = initText ?? "";
    return Card(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: publicRoundedRadius),
      margin: EdgeInsets.zero,
      elevation: 0,
      child: SizedBox(
        height: height,
        child: TextFormField(
          autofocus: autoFocus,
          obscureText: isTextPassword ?? false,
          maxLines: maxLines,
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
                color: theme.colorScheme.secondary,
                width: 1,
              ),
            ),
            isDense: false,
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(
                bottom: 18.0, top: 16, left: 10.0, right: 10),
            hintText: hint,
            border: InputBorder.none,
            prefixIcon: prefix,
            prefixIconColor: textColor ?? theme.colorScheme.surfaceTint,
          ),
          cursorColor: theme.colorScheme.primary,
          keyboardType: textInputType,
          onFieldSubmitted: onSaved,
        ),
      ),
    );
  }
}
