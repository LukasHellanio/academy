import 'package:encora_community/core/utils/toast_utils.dart';
import 'package:encora_community/widgets/modais/modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerOptions extends StatelessWidget {
  const DrawerOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(left: 20),
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text('Profile', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.message, color: Colors.white),
            title: Text('Message', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.white),
            title: Text('Notifications', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.white),
            title: Text('About', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              showLogoutConfirmationDialog(context, () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  showCustomToast(context, 'Logout failed: $e', "warning");
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
