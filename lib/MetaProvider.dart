import 'package:flutter/material.dart';

// Classe para representar uma meta
class Meta {
  String titulo;
  DateTime prazo;
  double progresso; // Em porcentagem (0.0 a 1.0)

  Meta({required this.titulo, required this.prazo, this.progresso = 0.0});
}

// Classe que gerencia o estado das metas usando Provider
class MetaProvider extends ChangeNotifier {
  List<Meta> _metas = []; // Lista de metas

  List<Meta> get metas => _metas;

  void adicionarMeta(Meta meta) {
    _metas.add(meta);
    notifyListeners(); // Notifica os ouvintes (widgets) que os dados foram alterados
  }

  void editarMeta(int index, Meta novaMeta) {
    _metas[index] = novaMeta;
    notifyListeners();
  }

  void deletarMeta(int index) {
    _metas.removeAt(index);
    notifyListeners();
  }
}
