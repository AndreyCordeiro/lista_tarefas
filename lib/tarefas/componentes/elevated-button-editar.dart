import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/edicao/edicao-tarefa-page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../tarefa.dart';

class BotaoEditar extends StatelessWidget {
  Tarefa? tarefa;


  BotaoEditar({required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EdicaoTarefaPage(tarefa!),
              ),
            );
          },
          child: const Text("Editar"),
        ),
      ),
    );
  }

  Future<int?> _editar(String nome, String descricao) async {
    String path = join(await getDatabasesPath(), 'task_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> editar;

    sql = "UPDATE tarefa SET nome = ? and descricao = ?";
    editar = dataBase.rawUpdate(sql, [nome, descricao]);

    return editar;
  }
}
