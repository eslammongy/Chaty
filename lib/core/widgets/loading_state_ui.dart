import 'package:flutter/material.dart';
import 'package:chaty/core/constants/app_assets.dart';

class LoadingStateUI extends StatelessWidget {
  const LoadingStateUI({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 160,
      width: 90,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: theme.colorScheme.surfaceDim),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppAssetsManager.loading,
                width: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: theme.textTheme.titleLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
