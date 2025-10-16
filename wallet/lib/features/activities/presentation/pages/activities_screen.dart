import 'package:flutter/material.dart';
import '../../domain/entities/activity.dart';
import '../../../../core/constants/app_colors.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _selectedIndex = 3; // Activities tab is at index 3

  final List<Activity> _activities = [
    Activity(
      id: '1',
      type: ActivityType.received,
      title: 'Received Bitcoin',
      subtitle: '2 hours ago',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      amount: '+0.005 BTC',
      usdValue: '+\$185.00',
      currency: 'BTC',
      isPositive: true,
    ),
    Activity(
      id: '2',
      type: ActivityType.sent,
      title: 'Sent Ethereum',
      subtitle: 'Oct 26, 10:30 AM',
      timestamp: DateTime(2025, 10, 26, 10, 30),
      amount: '-0.1 ETH',
      usdValue: '-\$350.50',
      currency: 'ETH',
      isPositive: false,
    ),
    Activity(
      id: '3',
      type: ActivityType.swapped,
      title: 'Swapped USDT for ADA',
      subtitle: 'Oct 25, 08:00 PM',
      timestamp: DateTime(2025, 10, 25, 20, 0),
      amount: '500 USDT',
      usdValue: '-\$500.00',
      currency: 'USDT',
      isPositive: false,
    ),
    Activity(
      id: '4',
      type: ActivityType.deposited,
      title: 'Deposited fiat to wallet',
      subtitle: 'Oct 25, 03:15 PM',
      timestamp: DateTime(2025, 10, 25, 15, 15),
      amount: '1000 USD',
      usdValue: '+\$1000.00',
      currency: 'USD',
      isPositive: true,
    ),
    Activity(
      id: '5',
      type: ActivityType.sent,
      title: 'Sent Litecoin',
      subtitle: 'Oct 24, 08:00 AM',
      timestamp: DateTime(2025, 10, 24, 8, 0),
      amount: '-0.5 LTC',
      usdValue: '-\$65.20',
      currency: 'LTC',
      isPositive: false,
    ),
    Activity(
      id: '6',
      type: ActivityType.received,
      title: 'Received Solana',
      subtitle: 'Oct 23, 07:45 PM',
      timestamp: DateTime(2025, 10, 23, 19, 45),
      amount: '+0.05 SOL',
      usdValue: '+\$10.75',
      currency: 'SOL',
      isPositive: true,
    ),
    Activity(
      id: '7',
      type: ActivityType.withdrew,
      title: 'Withdrew funds to bank',
      subtitle: 'Oct 22, 11:20 AM',
      timestamp: DateTime(2025, 10, 22, 11, 20),
      amount: '200 USD',
      usdValue: '-\$200.00',
      currency: 'USD',
      isPositive: false,
    ),
    Activity(
      id: '8',
      type: ActivityType.swapped,
      title: 'Swapped DOGE for SHIB',
      subtitle: 'Oct 21, 02:00 PM',
      timestamp: DateTime(2025, 10, 21, 14, 0),
      amount: '1000 DOGE',
      usdValue: '-\$65.00',
      currency: 'DOGE',
      isPositive: false,
    ),
  ];

  void _onBottomNavTapped(int index) {
    if (index == 2) {
      // Navigate to Swap screen
      Navigator.pushNamed(context, '/swap');
    } else if (index == 0) {
      // Navigate to Portfolio screen
      Navigator.pushNamedAndRemoveUntil(context, '/portfolio', (route) => false);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.received:
        return const Color(0xFF4CAF50);
      case ActivityType.sent:
        return const Color(0xFFFF5252);
      case ActivityType.swapped:
        return const Color(0xFF2196F3);
      case ActivityType.deposited:
        return const Color(0xFF9C27B0);
      case ActivityType.withdrew:
        return const Color(0xFFFF9800);
    }
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.received:
        return Icons.arrow_downward;
      case ActivityType.sent:
        return Icons.arrow_upward;
      case ActivityType.swapped:
        return Icons.swap_horiz;
      case ActivityType.deposited:
        return Icons.account_balance_wallet;
      case ActivityType.withdrew:
        return Icons.account_balance;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Recent Activities',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.access_time, color: Colors.grey),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.grey, size: 20),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          final color = _getActivityColor(activity.type);
          final icon = _getActivityIcon(activity.type);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Activity Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // Activity Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.subtitle,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                // Amount and Value
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      activity.amount,
                      style: TextStyle(
                        color: activity.isPositive
                            ? const Color(0xFF4CAF50)
                            : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity.usdValue,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Swap',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              activeIcon: Icon(Icons.history),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new transaction action
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
