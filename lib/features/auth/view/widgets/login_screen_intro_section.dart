import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chaty/core/constants/app_assets.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class LoginScreenIntroSection extends StatelessWidget {
  const LoginScreenIntroSection({
    Key? key,
    required this.introText,
    required this.subIntroText,
  }) : super(key: key);
  final String introText;
  final String subIntroText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            AppAssetsManager.appLogo,
            width: 80,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          introText,
          style: theme.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          subIntroText,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.surfaceTint),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
