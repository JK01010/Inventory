import 'package:flutter/material.dart';

class SingleHeadingText extends StatelessWidget {
  const SingleHeadingText({
    super.key,
    required this.title,
    this.value,
  });

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelSmall,
        ),
        Text(value ?? "-", style: textTheme.titleMedium)

      ],
    );
  }
}
