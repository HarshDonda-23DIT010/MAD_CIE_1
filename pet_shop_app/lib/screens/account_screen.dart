import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: AppColors.white, size: 36),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pet Lover',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'petlover@pawshop.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.edit, color: AppColors.white, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Menu Items
              _buildMenuSection('My Account', [
                _MenuItem(Icons.shopping_bag_outlined, 'My Orders', ''),
                _MenuItem(Icons.location_on_outlined, 'Delivery Address', ''),
                _MenuItem(Icons.payment_outlined, 'Payment Methods', ''),
                _MenuItem(Icons.card_giftcard_outlined, 'Promo Codes', '1 available'),
              ]),
              const SizedBox(height: 16),
              _buildMenuSection('My Pets', [
                _MenuItem(Icons.pets, 'My Pet Profiles', '2 pets'),
                _MenuItem(Icons.calendar_today_outlined, 'Appointments', ''),
                _MenuItem(Icons.vaccines_outlined, 'Vaccination Records', ''),
              ]),
              const SizedBox(height: 16),
              _buildMenuSection('Settings', [
                _MenuItem(Icons.notifications_outlined, 'Notifications', ''),
                _MenuItem(Icons.help_outline, 'Help & Support', ''),
                _MenuItem(Icons.info_outline, 'About PawShop', ''),
                _MenuItem(Icons.logout, 'Log Out', '', isDestructive: true),
              ]),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      item.icon,
                      color: item.isDestructive ? AppColors.red : AppColors.primary,
                      size: 22,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: item.isDestructive ? AppColors.red : AppColors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item.subtitle.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.subtitle,
                              style: const TextStyle(fontSize: 11, color: AppColors.primary),
                            ),
                          ),
                        const SizedBox(width: 4),
                        if (!item.isDestructive)
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.grey,
                          ),
                      ],
                    ),
                  ),
                  if (index < items.length - 1)
                    const Divider(height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDestructive;

  _MenuItem(this.icon, this.title, this.subtitle, {this.isDestructive = false});
}
