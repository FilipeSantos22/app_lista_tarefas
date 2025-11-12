import 'package:app_lista_tarefas/models/tarefa_model.dart';
import 'package:app_lista_tarefas/services/armazenamento_service.dart';
import 'package:flutter/material.dart';
import '../models/tarefa_model.dart';
import '../services/armazenamento_service.dart';

class TarefaController extends ChangeNotifier {
  final ArmazenamentoService _armazenamento = ArmazenamentoService();
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas => _tarefas;

  // Carrega as tarefas salvas no app
  Future<void> carregarTarefas() async {
    _tarefas = await _armazenamento.carregarTarefas();
    notifyListeners(); // Notifica a interface que houve mudança
  }

  // Adiciona uma nova tarefa
  Future<void> adicionarTarefa(String titulo) async {
    if (titulo.trim().isEmpty) return;
    final novaTarefa = Tarefa(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: titulo,
      concluida: false,
      idUsuario: '',
    );
    _tarefas.add(novaTarefa);
    await _armazenamento.salvarTarefas(_tarefas);
    notifyListeners();
  }

  // Marca tarefa como concluída ou não
  Future<void> alternarConclusao(String id) async {
    final indice = _tarefas.indexWhere((t) => t.id == id);
    if (indice != -1) {
      _tarefas[indice].concluida = !_tarefas[indice].concluida;
      await _armazenamento.salvarTarefas(_tarefas);
      notifyListeners();
    }
  }

  // Remove uma tarefa
  Future<void> removerTarefa(String id) async {
    _tarefas.removeWhere((t) => t.id == id);
    await _armazenamento.salvarTarefas(_tarefas);
    notifyListeners();
  }

  // Limpa todas as tarefas
  Future<void> limparTarefas() async {
    _tarefas.clear();
    await _armazenamento.limparTarefas();
    notifyListeners();
  }
}
