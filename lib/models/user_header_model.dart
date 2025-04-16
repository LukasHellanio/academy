import 'package:flutter/material.dart';

class UserHeaderModel {
  final String name;
  final String avatarUrl;
  final String description;
  final IconData? rightIcon;

  UserHeaderModel({
    required this.name,
    required this.avatarUrl,
    required this.description,
    this.rightIcon,
  });
}
