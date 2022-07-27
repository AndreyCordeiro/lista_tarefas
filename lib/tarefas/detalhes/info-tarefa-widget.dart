import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/model/tarefa.dart';

import '../componentes/elevated-button-editar.dart';
import '../componentes/elevated-button-excluir.dart';
import '../edicao/edicao-tarefa-page.dart';
import 'info-tarefa-page.dart';

class InfoTarefaWidget extends StatefulWidget {
  Tarefa tarefa;

  InfoTarefaWidget({required this.tarefa});

  @override
  State<InfoTarefaWidget> createState() =>
      _detalhesTarefasReativa(tarefa: tarefa);
}

class _detalhesTarefasReativa extends State<InfoTarefaWidget> {
  Tarefa tarefa;

  _detalhesTarefasReativa({required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var larguraTela = constraints.biggest.width;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Detalhes da Tarefa"),
          ),
          body: Container(
            padding: const EdgeInsets.only(
              left: 25,
              top: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Tarefa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(tarefa.nome),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Descrição',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(tarefa.descricao),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      BotaoExcluir(tarefa: tarefa, largura: larguraTela / 4),
                      const SizedBox(width: 60),
                      BotaoEditar(tarefa: tarefa, largura: larguraTela / 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
