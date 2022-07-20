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
}
