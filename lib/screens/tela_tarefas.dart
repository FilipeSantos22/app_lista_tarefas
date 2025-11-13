import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';
import '../widgets/widgets.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TarefaController>(context, listen: false).carregarTarefas();
    });
  }

  @override
  void dispose() {
    _controllerTitulo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<TarefaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas 🧩'),
        centerTitle: true,
        actions: [
          if (controlador.usandoCache) const BadgeOffline(),
        ],
      ),
      body: Column(
        children: [
          if (controlador.erro != null)
            BannerErro(
              mensagem: controlador.erro!,
              onFechar: () => controlador.carregarTarefas(),
            ),

          InputNovaTarefa(
            controller: _controllerTitulo,
            onAdicionar: () {
              controlador.adicionarTarefa(_controllerTitulo.text);
              _controllerTitulo.clear();
            },
          ),

          Expanded(
            child: controlador.tarefas.isEmpty
                ? EstadoVazio(
                    mostrarBotaoReconectar: controlador.usandoCache,
                    onReconectar: () => controlador.atualizarDaApi(),
                  )
                : RefreshIndicator(
                        onRefresh: () => controlador.atualizarDaApi(),
                        child: ListView.builder(
                          itemCount: controlador.tarefas.length,
                          itemBuilder: (context, index) {
                            final tarefa = controlador.tarefas[index];
                            return TarefaItem(
                              tarefa: tarefa,
                              onAlternarConclusao: () =>
                                  controlador.alternarConclusao(tarefa.id),
                              onRemover: () =>
                                  controlador.removerTarefa(tarefa.id),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
