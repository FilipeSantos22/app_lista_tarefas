import 'package:flutter/material.dart';

class InputNovaTarefa extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdicionar;

  const InputNovaTarefa({
    super.key,
    required this.controller,
    required this.onAdicionar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nova tarefa',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAdicionar,
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
