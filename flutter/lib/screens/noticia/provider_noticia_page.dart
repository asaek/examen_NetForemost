import 'package:flutter/material.dart';
import 'package:trainee/models/articulos_model.dart';

class NoticiaPageProvider with ChangeNotifier {
  Articulo? _articulo;
  Articulo? get getArticulo => _articulo;
  set setArticulo(Articulo articulo) {
    _articulo = articulo;
  }
}
