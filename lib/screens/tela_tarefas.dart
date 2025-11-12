import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';
import '../models/tarefa_model.dart';

class TelaTarefas extends StatefulWidget {
  const TelaTarefas({super.key});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  final TextEditingController _controllerTitulo = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carrega as tarefas ao iniciar a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TarefaController>(context, listen: false).carregarTarefas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<TarefaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas 🧩'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Campo para adicionar nova tarefa
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerTitulo,
                    decoration: const InputDecoration(
                      labelText: 'Nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    controlador.adicionarTarefa(_controllerTitulo.text);
                    _controllerTitulo.clear();
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),

          // Lista de tarefas
          Expanded(
            child: controlador.tarefas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma tarefa adicionada ainda!',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: controlador.tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = controlador.tarefas[index];
                      return Dismissible(
                        key: Key(tarefa.id),
                        background: Container(color: Colors.red),
                        onDismissed: (_) =>
                            controlador.removerTarefa(tarefa.id),
                        child: ListTile(
                          title: Text(
                            tarefa.titulo,
                            style: TextStyle(
                              decoration: tarefa.concluida
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Icon(
                            tarefa.concluida
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color:
                                tarefa.concluida ? Colors.green : Colors.grey,
                          ),
                          onTap: () =>
                              controlador.alternarConclusao(tarefa.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
