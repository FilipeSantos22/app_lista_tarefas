import 'package:flutter/material.dart';
import '../models/tarefa_model.dart';

class TarefaItem extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback onAlternarConclusao;
  final VoidCallback onRemover;

  const TarefaItem({
    super.key,
    required this.tarefa,
    required this.onAlternarConclusao,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(tarefa.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      ),
      onDismissed: (_) => onRemover(),
      child: ListTile(
        title: Text(
          tarefa.titulo,
          style: TextStyle(
            decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Icon(
          tarefa.concluida ? Icons.check_circle : Icons.circle_outlined,
          color: tarefa.concluida ? Colors.green : Colors.grey,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: onRemover,
        ),
        onTap: onAlternarConclusao,
      ),
    );
  }
}
