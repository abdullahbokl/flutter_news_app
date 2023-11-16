import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int maxLines;
  final double? fontSize;
  final TextStyle? style;

  final bool? isBold;

  const CustomText({
    Key? key,
    required this.text,
    this.maxLines = 1,
    this.style,
    this.fontSize,
    this.isBold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
            fontSize: fontSize ?? 16.0,
            fontWeight: isBold ?? false ? FontWeight.bold : FontWeight.normal,
          ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}
