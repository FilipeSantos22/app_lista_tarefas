class Tarefa {
  final String id;
  final String idUsuario;
  final String titulo;
  bool concluida;

  Tarefa({
    required this.id,
    required this.idUsuario,
    required this.titulo,
    this.concluida = false,
  });

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'] as String,
      idUsuario: json['userId'] as String,
      titulo: json['title'] as String,
      concluida: json['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUsuario': idUsuario,
      'titulo': titulo,
      'concluida': concluida,
    };
  }
}