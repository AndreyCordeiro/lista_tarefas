import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/tarefa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'cadastro/cadastro-tarefa-page.dart';
import 'info-tarefa-page.dart';

class ListaTarefas extends StatelessWidget {
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
                  nome: tarefa['nome'].toString(),
                  descricao: tarefa['descricao'].toString());

              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.pinkAccent,
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
                        builder: (context) => InfoTarefaPage(task),
                      ),
                    );
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
          id INT PRIMARY KEY,
          nome TEXT NOT NULL,
          descricao TEXT NOT NULL)
        ''');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Projeto Integrador II", "projeto teste 1")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Construção de Software", "projeto teste 2")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Programação Web", "projeto teste 3")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Sistemas Operacionais", "projeto teste 4")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Desenvolvimento para Dispositivos Móveis", "projeto teste 5")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Arquitetura e Padrões de Software", "projeto teste 6")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Probabilidade e Estatística", "projeto teste 7")');
        db.execute(
            'INSERT INTO tarefa (nome, descricao) VALUES ("Teoria da Computação", "projeto teste 8")');
      },
    );
    List<Map<String, Object?>> retorno =
        await dataBase.rawQuery('SELECT * FROM tarefa');
    return retorno;
  }
}
