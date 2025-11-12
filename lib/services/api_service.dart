import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tarefa_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _todosEndpoint = '/todos';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<Tarefa>> buscarTarefas({int limite = 20}) async {
    try {
      final url = Uri.parse('$_baseUrl$_todosEndpoint?_limit=$limite');
      
      final response = await http
          .get(url)
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> dadosJson = jsonDecode(response.body);
        return dadosJson
            .map((json) => Tarefa.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Erro ao buscar tarefas: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Erro de conexão: $e', null);
    } catch (e) {
      throw ApiException('Erro inesperado ao buscar tarefas: $e', null);
    }
  }

  Future<Tarefa> criarTarefa({
    required String titulo,
    int userId = 1,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl$_todosEndpoint');
      final body = jsonEncode({
        'title': titulo,
        'userId': userId,
        'completed': false,
      });

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(_timeout);

      if (response.statusCode == 201) {
        final dadosJson = jsonDecode(response.body) as Map<String, dynamic>;
        return Tarefa.fromJson(dadosJson);
      } else {
        throw ApiException(
          'Erro ao criar tarefa: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Erro de conexão: $e', null);
    } catch (e) {
      throw ApiException('Erro inesperado ao criar tarefa: $e', null);
    }
  }

  Future<Tarefa> atualizarTarefa({
    required int id,
    required bool concluida,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl$_todosEndpoint/$id');
      
      final body = jsonEncode({
        'completed': concluida,
      });

      final response = await http
          .patch(
            url,
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final dadosJson = jsonDecode(response.body) as Map<String, dynamic>;
        return Tarefa.fromJson(dadosJson);
      } else {
        throw ApiException(
          'Erro ao atualizar tarefa: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Erro de conexão: $e', null);
    } catch (e) {
      throw ApiException('Erro inesperado ao atualizar tarefa: $e', null);
    }
  }

  Future<void> deletarTarefa(int id) async {
    try {
      final url = Uri.parse('$_baseUrl$_todosEndpoint/$id');

      final response = await http
          .delete(url)
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw ApiException(
          'Erro ao deletar tarefa: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Erro de conexão: $e', null);
    } catch (e) {
      throw ApiException('Erro inesperado ao deletar tarefa: $e', null);
    }
  }

  Future<Tarefa> buscarTarefaPorId(int id) async {
    try {
      final url = Uri.parse('$_baseUrl$_todosEndpoint/$id');

      final response = await http
          .get(url)
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final dadosJson = jsonDecode(response.body) as Map<String, dynamic>;
        return Tarefa.fromJson(dadosJson);
      } else if (response.statusCode == 404) {
        throw ApiException('Tarefa não encontrada', 404);
      } else {
        throw ApiException(
          'Erro ao buscar tarefa: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Erro de conexão: $e', null);
    } catch (e) {
      throw ApiException('Erro inesperado ao buscar tarefa: $e', null);
    }
  }
}

class ApiException implements Exception {
  final String mensagem;
  final int? statusCode;

  ApiException(this.mensagem, this.statusCode);

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException [$statusCode]: $mensagem';
    }
    return 'ApiException: $mensagem';
  }

  bool get isConnectionError => statusCode == null;
  bool get isNotFound => statusCode == 404;
  bool get isServerError => statusCode != null && statusCode! >= 500;
}
