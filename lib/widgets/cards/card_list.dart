import 'package:flutter/material.dart';
import '../../models/card_item_model.dart';

class CardList extends StatelessWidget {
  final List<CardItemModel> items;

  const CardList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/manager');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(
                alpha: (0.01 * 255).toDouble(),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(item.avatarUrl),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.trailingText != null)
                  Text(
                    item.trailingText!,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                if (item.trailingIcon != null)
                  Icon(item.trailingIcon, color: item.trailingIconColor),
              ],
            ),
          ),
        );
      },
    );
  }
}
