import 'package:flutter/material.dart';
import '../../subscription/presentation/subscription_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      body: SafeArea(
        top: false, // Maintain full-bleed purple header
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B137B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.amber,
                        child: Text('PI', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              const Text('Pandit Iyer', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Vedic Priest', style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 20)),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileStat('142', 'Bookings'),
                  _buildProfileStat('12', 'Years Exp.'),
                  _buildProfileStat('4.8', 'Rating'),
                ],
              ),
              const SizedBox(height: 32),
              _buildMenuItem(Icons.person_outline, 'Edit Profile', () {}),
              _buildMenuItem(Icons.workspace_premium_outlined, 'Expertise & Services', () {}),
              _buildMenuItem(Icons.phone_outlined, 'Contact Details', () {}),
              _buildMenuItem(Icons.account_balance_outlined, 'Bank Details', () {}),
              _buildMenuItem(Icons.card_membership_outlined, 'Subscription', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionScreen()));
              }),
              _buildMenuItem(Icons.notifications_none, 'Notifications', () {}),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.purple.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: const Color(0xFF3B137B), size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
