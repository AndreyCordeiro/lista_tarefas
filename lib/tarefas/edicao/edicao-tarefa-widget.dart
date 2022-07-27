import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../detalhes/info-tarefa-page.dart';
import '../model/tarefa.dart';
import 'edicao-tarefa-page.dart';

class EditarTarefa extends State<EdicaoTarefaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Tarefa tarefa;
  String? nome;
  String? descricao;

  EditarTarefa({required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Tarefa"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: tarefa.nome,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome da tarefa!';
                  }
                  nome = value;
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: tarefa.descricao,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição da tarefa!';
                  }
                  descricao = value;
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _atualizar(nome!, descricao!, tarefa.id);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _atualizar(String nome, String descricao, [int? id]) async {
    String path = join(await getDatabasesPath(), 'task_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> linhasAfetadas;

    sql = "UPDATE tarefa SET nome = ?, descricao = ? WHERE id = ?";
    linhasAfetadas = dataBase.rawInsert(sql, [nome, descricao, id]);

    return linhasAfetadas;
  }
}
