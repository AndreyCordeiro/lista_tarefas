import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/cadastro/cadastro-tarefa-page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CadastroTarefa extends State<CadastroTarefaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? nome;
  String? descricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Tarefa"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nome da tarefa',
                ),
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
                decoration: const InputDecoration(
                  hintText: 'Subtitulo da tarefa',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o subtitulo da tarefa!';
                  }
                  descricao = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _salvar(nome!, descricao!);
                  }
                },
                child: const Text('Salvar'),
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
