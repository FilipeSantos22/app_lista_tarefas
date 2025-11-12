import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/tarefa_controller.dart';
import 'screens/tela_tarefas.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TarefaController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Lista de Tarefas',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        home: const TelaTarefas(),
      ),
    );
  }
}
