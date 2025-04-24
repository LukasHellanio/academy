import 'package:flutter/material.dart';
import '../data/models/user_header_model.dart';

class AppHeader extends StatelessWidget {
  final UserHeaderModel user;

  const AppHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Avatar + Info
          Expanded(
            child: Row(
              children: [
                // Check if avatarUrl is not empty
                ClipOval(
                  child:
                      user.avatarUrl.isNotEmpty
                          ? Image.network(
                            user.avatarUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                          : Icon(
                            Icons.account_circle,
                            size: 70,
                            color: theme.primaryColor,
                          ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        user.description,
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Optional icon (right)
          if (user.rightIcon != null) Icon(user.rightIcon, color: Colors.green),
        ],
      ),
    );
  }
}
