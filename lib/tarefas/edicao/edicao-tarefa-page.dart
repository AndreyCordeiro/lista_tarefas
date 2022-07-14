import 'package:flutter/material.dart';

import '../tarefa.dart';
import 'edicao-tarefa-widget.dart';

class EdicaoTarefaPage extends StatefulWidget {
  Tarefa tarefa;

  EdicaoTarefaPage(this.tarefa);

  @override
  State<EdicaoTarefaPage> createState() => EditarTarefa(tarefa: tarefa);
}
