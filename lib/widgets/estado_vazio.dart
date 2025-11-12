import 'package:flutter/material.dart';

class EstadoVazio extends StatelessWidget {
  final bool mostrarBotaoReconectar;
  final VoidCallback? onReconectar;

  const EstadoVazio({
    super.key,
    this.mostrarBotaoReconectar = false,
    this.onReconectar,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma tarefa adicionada ainda!',
            style: TextStyle(fontSize: 16),
          ),
          if (mostrarBotaoReconectar && onReconectar != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onReconectar,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar conectar novamente'),
            ),
          ],
        ],
      ),
    );
  }
}
