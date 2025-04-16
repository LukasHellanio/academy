import 'package:encora_community/data/mock_expandable_cards.dart';
import 'package:encora_community/widgets/cards/expandable_card';
import 'package:flutter/material.dart';
import 'package:encora_community/widgets/app_header.dart';
import 'package:encora_community/models/user_header_model.dart';

class ManagerDetailPage extends StatelessWidget {
  const ManagerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mockado só pra exibir algo por enquanto
    final mockManager = UserHeaderModel(
      name: 'Glauco Luiz Fadel',
      avatarUrl: 'https://picsum.photos/200',
      description: 'Manager',
      rightIcon: Icons.check_circle,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Manager Details'),
        backgroundColor: theme.primaryColor.withValues(
          alpha: (0.01 * 255).toDouble(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppHeader(user: mockManager),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockExpandableCards.length,
              itemBuilder: (context, index) {
                final card = mockExpandableCards[index];
                return ExpandableCard(card: card);
              },
            ),
          ],
        ),
      ),
    );
  }
}
