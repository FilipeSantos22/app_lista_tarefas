import 'package:flutter/material.dart';

class BadgeOffline extends StatelessWidget {
  const BadgeOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        avatar: const Icon(Icons.cloud_off, size: 16),
        label: const Text(
          'Offline',
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.orange.shade100,
      ),
    );
  }
}
