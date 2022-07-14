import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../tarefa.dart';

class BotaoExcluir extends StatelessWidget {
  Tarefa? tarefa;

  BotaoExcluir({required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              _excluir(tarefa!.nome, tarefa!.descricao);
            },
            style: ElevatedButton.styleFrom(primary: Colors.red),
            child: const Text("Excluir"),
          ),
        ),
      ],
    );
  }

  Future<int?> _excluir(String nome, String descricao) async {
    String path = join(await getDatabasesPath(), 'task_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> delete;

    sql = "DELETE FROM tarefa WHERE nome = ? and descricao = ?";
    delete = dataBase.rawInsert(sql, [nome, descricao]);

    return delete;
  }
}
