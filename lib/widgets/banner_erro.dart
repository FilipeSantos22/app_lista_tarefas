import 'package:flutter/material.dart';

class BannerErro extends StatelessWidget {
  final String mensagem;
  final VoidCallback onFechar;

  const BannerErro({
    super.key,
    required this.mensagem,
    required this.onFechar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.red.shade100,
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              mensagem,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: onFechar,
          ),
        ],
      ),
    );
  }
}
