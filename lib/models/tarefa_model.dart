class Tarefa {
  final int id;
  final int idUsuario;
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
      id: json['id'] as int,
      idUsuario: json['userId'] as int,
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