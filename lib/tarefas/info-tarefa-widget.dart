import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/tarefa.dart';

import 'componentes/elevated-button-excluir.dart';
import 'info-tarefa-page.dart';

class InfoTarefaWidget extends State<InfoTarefaPage> {
  Tarefa tarefa;

  InfoTarefaWidget({required this.tarefa});

  @override
  Widget build(BuildContext context) {
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
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('Tarefa: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 50),
                        Text(
                          tarefa.nome,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('Descrição: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 30),
                        Text(tarefa.descricao, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            BotaoExcluir(tarefa: tarefa),
          ],
        ),
      ),
    );
  }
}
