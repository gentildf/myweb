import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importe o pacote intl para usar DateFormat
import 'package:provider/provider.dart';
import 'package:myweb/MetaProvider.dart'; // Importe a classe Meta e MetaProvider que você criou

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  TextEditingController tituloController = TextEditingController();
  DateTime? prazoSelecionado;

  bool editing = false; // Flag para indicar se estamos editando uma meta existente
  int? indexEdit; // Índice da meta que estamos editando

  void adicionarMeta(MetaProvider metaProvider) {
    String titulo = tituloController.text;
    DateTime prazo = prazoSelecionado ?? DateTime.now(); // Use prazoSelecionado se não for nulo, caso contrário, use a data atual

    if (titulo.isEmpty) {
      return;
    }

    if (editing) {
      // Editando uma meta existente
      Meta novaMeta = Meta(titulo: titulo, prazo: prazo);
      metaProvider.editarMeta(indexEdit!, novaMeta);
      editing = false;
      indexEdit = null;
    } else {
      // Adicionando uma nova meta
      Meta novaMeta = Meta(titulo: titulo, prazo: prazo);
      metaProvider.adicionarMeta(novaMeta);
    }

    // Limpar os campos após adicionar/editar a meta
    tituloController.clear();
    prazoSelecionado = null;
  }

  void selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (dataSelecionada != null) {
      setState(() {
        prazoSelecionado = dataSelecionada;
      });
    }
  }

  void editarMeta(int index, MetaProvider metaProvider) {
    setState(() {
      editing = true;
      indexEdit = index;
      tituloController.text = metaProvider.metas[index].titulo;
      prazoSelecionado = metaProvider.metas[index].prazo;
    });
  }

  void deletarMeta(int index, MetaProvider metaProvider) {
    metaProvider.deletarMeta(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Metas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<MetaProvider>(
          builder: (context, metaProvider, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: 'Título da Meta',
                ),
              ),
              SizedBox(height: 10.0),
              prazoSelecionado == null
                  ? ElevatedButton(
                      onPressed: () => selecionarData(context),
                      child: Text('Selecionar Prazo'),
                    )
                  : Text('Prazo: ${DateFormat('dd/MM/yyyy').format(prazoSelecionado!)}'),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => adicionarMeta(metaProvider),
                child: Text(editing ? 'Editar Meta' : 'Adicionar Meta'),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: metaProvider.metas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(metaProvider.metas[index].titulo),
                        subtitle: Text('Prazo: ${DateFormat('dd/MM/yyyy').format(metaProvider.metas[index].prazo)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => editarMeta(index, metaProvider),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deletarMeta(index, metaProvider),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
