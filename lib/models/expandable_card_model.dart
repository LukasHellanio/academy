import 'package:flutter/material.dart';

class ExpandableCardModel {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final String trailingText;
  final List<String> details;

  ExpandableCardModel({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingText,
    required this.details,
  });
}
