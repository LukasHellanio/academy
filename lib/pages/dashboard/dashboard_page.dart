import 'package:encora_community/data/mock/mock_activities.dart';
import 'package:encora_community/data/models/user_header_model.dart';
import 'package:encora_community/providers/user_provider.dart';
import 'package:encora_community/widgets/app_header.dart';
import 'package:encora_community/widgets/cards/card_list.dart';
import 'package:encora_community/widgets/cards/highlight_card.dart';
import 'package:encora_community/widgets/cards/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    final user = UserHeaderModel(
      name: userProvider.name ?? 'Guest',
      avatarUrl: userProvider.avatarUrl ?? '',
      description: userProvider.userType ?? 'Unknown',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(user: user),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                StatCard(icon: Icons.group, label: 'Managers', value: '12'),
                StatCard(
                  icon: Icons.lock_open,
                  label: 'Permissions',
                  value: '24',
                ),
                StatCard(
                  icon: Icons.calendar_month,
                  label: 'Events',
                  value: '5',
                ),
                StatCard(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  value: '8',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: HighlightCard(
              icon: Icons.info_outline,
              description:
                  'Remember to check your permissions and update managers weekly.',
            ),
          ),
          const SizedBox(height: 20),
          Expanded(child: CardList(items: mockActivities)),
        ],
      ),
    );
  }
}
