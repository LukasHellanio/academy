import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final String type; // 'danger', 'info', 'warning'

  const CustomToast({Key? key, required this.message, required this.type})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    // Determine the colors based on the type
    switch (type) {
      case 'danger':
        bgColor = Colors.red[300]!;
        textColor = Colors.white;
        break;
      case 'info':
        bgColor = Colors.blue[300]!;
        textColor = Colors.white;
        break;
      case 'warning':
        bgColor = Colors.amber[300]!;
        textColor = Colors.black;
        break;
      default:
        bgColor = Colors.grey[800]!;
        textColor = Colors.white;
    }

    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: (0.3 * 255).toDouble()),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                type == 'danger'
                    ? Icons.error_outline
                    : type == 'info'
                    ? Icons.info_outline
                    : Icons.warning_amber_outlined,
                color: textColor,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: textColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
