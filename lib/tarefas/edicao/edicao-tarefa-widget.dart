import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../tarefa.dart';
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
                        _salvar(nome!, descricao!);
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
