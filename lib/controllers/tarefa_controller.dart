import 'package:flutter/material.dart';
import '../models/tarefa_model.dart';
import '../services/armazenamento_service.dart';
import '../services/api_service.dart';

class TarefaController extends ChangeNotifier {
  final ArmazenamentoService _armazenamento = ArmazenamentoService();
  final ApiService _apiService = ApiService();
  
  List<Tarefa> _tarefas = [];
  bool _isLoading = false;
  String? _erro;
  bool _usandoCache = false;

  List<Tarefa> get tarefas => _tarefas;
  bool get isLoading => _isLoading;
  String? get erro => _erro;
  bool get usandoCache => _usandoCache;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErro(String? mensagem) {
    _erro = mensagem;
    notifyListeners();
  }

  Future<void> carregarTarefas() async {
    _setLoading(true);
    _setErro(null);
    
    try {
      final tarefasApi = await _apiService.buscarTarefas(limite: 20);
      _tarefas = tarefasApi;
      _usandoCache = false;
      
      await _armazenamento.salvarTarefas(_tarefas);
      
    } on ApiException catch (e) {
      if (e.isConnectionError) {
        _setErro('Sem conexão. Exibindo tarefas salvas.');
      } else {
        _setErro('Erro na API: ${e.mensagem}');
      }
      
      _tarefas = await _armazenamento.carregarTarefas();
      _usandoCache = true;
      
    } catch (e) {
      _setErro('Erro ao carregar tarefas: $e');
      _tarefas = await _armazenamento.carregarTarefas();
      _usandoCache = true;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> adicionarTarefa(String titulo) async {
    if (titulo.trim().isEmpty) {
      _setErro('O título da tarefa não pode estar vazio');
      return;
    }
    
    _setErro(null);
    Tarefa novaTarefa;
    
    try {
      novaTarefa = await _apiService.criarTarefa(titulo: titulo);
      
      novaTarefa = Tarefa(
        id: DateTime.now().millisecondsSinceEpoch,
        idUsuario: novaTarefa.idUsuario,
        titulo: novaTarefa.titulo,
        concluida: novaTarefa.concluida,
      );
      
    } on ApiException {
      _setErro('Tarefa criada localmente (offline)');
      
      novaTarefa = Tarefa(
        id: DateTime.now().millisecondsSinceEpoch,
        titulo: titulo,
        concluida: false,
        idUsuario: 1,
      );
      
    } catch (e) {
      _setErro('Erro ao adicionar tarefa: $e');
      return;
    }
    
    try {
      _tarefas.insert(0, novaTarefa);
      await _armazenamento.salvarTarefas(_tarefas);
      notifyListeners();
    } catch (e) {
      _setErro('Erro ao salvar tarefa: $e');
    }
  }

  Future<void> alternarConclusao(int id) async {
    _setErro(null);
    
    final indice = _tarefas.indexWhere((t) => t.id == id);
    if (indice == -1) return;
    
    final estadoAnterior = _tarefas[indice].concluida;
    
    try {
      _tarefas[indice].concluida = !_tarefas[indice].concluida;
      notifyListeners();
      
      await _armazenamento.salvarTarefas(_tarefas);
      
      await _apiService.atualizarTarefa(
        id: id,
        concluida: _tarefas[indice].concluida,
      );
      
    } on ApiException catch (e) {
      if (e.isConnectionError) {
        _setErro('Offline: mudança salva localmente');
      } else {
        _setErro('Erro ao sincronizar com servidor');
      }
      
    } catch (e) {
      _setErro('Erro ao atualizar tarefa: $e');
      _tarefas[indice].concluida = estadoAnterior;
      await _armazenamento.salvarTarefas(_tarefas);
      notifyListeners();
    }
  }

  Future<void> removerTarefa(int id) async {
    _setErro(null);
    
    final indice = _tarefas.indexWhere((t) => t.id == id);
    if (indice == -1) return;
    
    final tarefaRemovida = _tarefas[indice];
    
    try {
      _tarefas.removeAt(indice);
      notifyListeners();
      
      await _armazenamento.salvarTarefas(_tarefas);
      await _apiService.deletarTarefa(id);
      
    } on ApiException catch (e) {
      if (e.isConnectionError) {
        _setErro('Offline: tarefa removida localmente');
      } else {
        _setErro('Erro ao sincronizar exclusão');
      }
      
    } catch (e) {
      _setErro('Erro ao remover tarefa: $e');
      _tarefas.insert(indice, tarefaRemovida);
      await _armazenamento.salvarTarefas(_tarefas);
      notifyListeners();
    }
  }

  Future<void> limparTarefas() async {
    _setErro(null);
    
    try {
      _tarefas.clear();
      await _armazenamento.limparTarefas();
      notifyListeners();
    } catch (e) {
      _setErro('Erro ao limpar tarefas: $e');
    }
  }

  Future<void> atualizarDaApi() async {
    _setLoading(true);
    _setErro(null);
    
    try {
      final tarefasApi = await _apiService.buscarTarefas(limite: 20);
      _tarefas = tarefasApi;
      _usandoCache = false;
      
      await _armazenamento.salvarTarefas(_tarefas);
      
    } on ApiException catch (e) {
      if (e.isConnectionError) {
        _setErro('Sem conexão com a internet');
      } else {
        _setErro('Erro ao atualizar: ${e.mensagem}');
      }
    } catch (e) {
      _setErro('Erro inesperado: $e');
    } finally {
      _setLoading(false);
    }
  }
}
