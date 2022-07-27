import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/tarefa.dart';

class BotaoExcluir extends StatelessWidget {
  Tarefa? tarefa;
  double? largura;

  BotaoExcluir({required this.tarefa, required this.largura});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: largura,
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
                    _excluir(tarefa!.id);
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context);
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

  Future<int?> _excluir(int? id) async {
    String path = join(await getDatabasesPath(), 'task_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> delete;

    sql = "DELETE FROM tarefa WHERE id = ?";
    delete = dataBase.rawInsert(sql, [id]);

    return delete;
  }
}
