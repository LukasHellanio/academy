import 'package:flutter/material.dart';
import '../../data/models/expandable_card_model.dart';

class ExpandableCard extends StatelessWidget {
  final ExpandableCardModel card;

  const ExpandableCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.primaryColor.withValues(alpha: (0.2 * 255).toDouble()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(card.leadingIcon),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(card.subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(card.trailingText, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 8),
            const Icon(Icons.expand_more),
          ],
        ),
        children:
            card.details
                .map(
                  (detail) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4,
                    ),
                    child: Text(detail),
                  ),
                )
                .toList(),
      ),
    );
  }
}
