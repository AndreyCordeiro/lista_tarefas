import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/model/tarefa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../cadastro/cadastro-tarefa-page.dart';
import '../detalhes/info-tarefa-page.dart';
import '../detalhes/info-tarefa-widget.dart';

class ListaTarefas extends StatefulWidget {
  @override
  State<ListaTarefas> createState() => _listaTarefasReativa();
}

class _listaTarefasReativa extends State<ListaTarefas> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: FutureBuilder(
        future: _buscarDados(),
        builder: (context,
            AsyncSnapshot<List<Map<String, Object?>>> dadosRetornados) {
          if (!dadosRetornados.hasData) {
            return const CircularProgressIndicator();
          }
          var listaTarefas = dadosRetornados.data!;

          return ListView.builder(
            itemCount: listaTarefas.length,
            itemBuilder: (context, index) {
              var tarefa = listaTarefas[index];
              Tarefa task = Tarefa(
                  id: tarefa['id'],
                  nome: tarefa['nome'].toString(),
                  descricao: tarefa['descricao'].toString());

              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors
                            .primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(9) * 100],
                    child: Text(listaTarefas[index]["nome"]
                        .toString()
                        .substring(0, 1)
                        .toUpperCase()),
                  ),
                  title: Text(tarefa['nome'].toString()),
                  subtitle: Text(tarefa['descricao'].toString()),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoTarefaWidget(tarefa: task),
                      ),
                    ).then((value) => setState(() {}));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroTarefaPage()),
          );
        },
      ),
    );
  }

  Future<List<Map<String, Object?>>> _buscarDados() async {
    String path = join(await getDatabasesPath(), 'task_list');
    // deleteDatabase(path);
    Database dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
          CREATE TABLE tarefa (
          id INTEGER PRIMARY KEY,
          nome TEXT NOT NULL,
          descricao TEXT NOT NULL)
        ''');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Projeto Integrador II", "projeto teste 1")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Constru????o de Software", "projeto teste 2")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Programa????o Web", "projeto teste 3")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Sistemas Operacionais", "projeto teste 4")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Desenvolvimento para Dispositivos M??veis", "projeto teste 5")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Arquitetura e Padr??es de Software", "projeto teste 6")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Probabilidade e Estat??stica", "projeto teste 7")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Teoria da Computa????o", "projeto teste 8")');
      },
    );
    List<Map<String, Object?>> retorno =
        await dataBase.rawQuery('SELECT * FROM tarefa');
    return retorno;
  }
}
