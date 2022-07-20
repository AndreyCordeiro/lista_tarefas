import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefas/model/tarefa.dart';

import 'info-tarefa-widget.dart';


class InfoTarefaPage extends StatefulWidget {
  Tarefa tarefa;

  InfoTarefaPage(this.tarefa);

  @override
  State<InfoTarefaPage> createState() => InfoTarefaWidget(tarefa: tarefa);
}