import 'package:flutter/material.dart';

class CardItemModel {
  final String avatarUrl;
  final String title;
  final String subtitle;
  final String? trailingText;
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final VoidCallback? onTap;

  CardItemModel({
    required this.avatarUrl,
    required this.title,
    required this.subtitle,
    this.trailingText,
    this.trailingIcon,
    this.trailingIconColor,
    this.onTap,
  });
}
