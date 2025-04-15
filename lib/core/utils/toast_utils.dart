// lib/core/utils/toast_utils.dart

import 'package:flutter/material.dart';
import 'package:encora_community/widgets/custom_toast.dart';

void showCustomToast(BuildContext context, String message, String type) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => CustomToast(message: message, type: type),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
