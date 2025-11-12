

import 'dart:convert';

import 'package:app_lista_tarefas/models/tarefa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArmazenamentoService {
  static const String _chaveTarefas = 'lista_tarefas';

  // Salva a lista de tarefas no armazenamento local
  Future<void> salvarTarefas(List<Tarefa> tarefas) async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = tarefas.map((t) => t.toJson()).toList();
    await prefs.setString(_chaveTarefas, jsonEncode(listaJson));
  }

  // Carrega as tarefas salvas do armazenamento local
  Future<List<Tarefa>> carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString(_chaveTarefas);
    if (dados == null) return [];
    final lista = jsonDecode(dados) as List;
    return lista.map((item) => Tarefa.fromJson(item)).toList();
  }

  // Remove todas as tarefas do armazenamento
  Future<void> limparTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveTarefas);
  }



}