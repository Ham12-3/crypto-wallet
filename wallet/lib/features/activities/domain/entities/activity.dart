enum ActivityType {
  received,
  sent,
  swapped,
  deposited,
  withdrew,
}

class Activity {
  final String id;
  final ActivityType type;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final String amount;
  final String usdValue;
  final String currency;
  final bool isPositive;

  Activity({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.amount,
    required this.usdValue,
    required this.currency,
    required this.isPositive,
  });
}
