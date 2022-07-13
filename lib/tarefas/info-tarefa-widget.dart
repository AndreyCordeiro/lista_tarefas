import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/tarefa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('Tarefa: '),
                        const SizedBox(width: 30),
                        Text(tarefa.nome),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('Descrição: '),
                        const SizedBox(width: 30),
                        Text(tarefa.descricao),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ButtonStyle(
                    backgroundColor:
                  ),
                  child: const Text('Excluir'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<int> _salvar(String nome, String descricao, [int? id]) async {
    String path = join(await getDatabasesPath(), 'task_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> linhasAfetadas;

    if (id == null) {
      sql = "INSERT INTO tarefa (nome, descricao) VALUES (?, ?)";
      linhasAfetadas = dataBase.rawInsert(sql, [nome, descricao]);
    } else {
      sql = "UPDATE tarefa SET nome = ?, descricao = ? WHERE id = ?";
      linhasAfetadas = dataBase.rawInsert(sql, [nome, descricao]);
    }
    return linhasAfetadas;
  }
}
