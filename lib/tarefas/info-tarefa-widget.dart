import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/tarefa.dart';

import 'componentes/elevated-button-editar.dart';
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
            BotaoExcluir(tarefa: tarefa),
            BotaoEditar(tarefa: tarefa),
          ],
        ),
      ),
    );
  }
}
