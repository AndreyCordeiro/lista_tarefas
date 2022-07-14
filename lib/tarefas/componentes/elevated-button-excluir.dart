import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../tarefa.dart';

class BotaoExcluir extends StatelessWidget {
  Tarefa? tarefa;

  BotaoExcluir({required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Excluir Tarefa'),
              content: const Text(
                  'Tem certeza que realmente deseja excluir esta Tarefa?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancelar'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    _excluir(tarefa!.nome, tarefa!.descricao);
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: const Text("Excluir"),
        ),
      ),
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
