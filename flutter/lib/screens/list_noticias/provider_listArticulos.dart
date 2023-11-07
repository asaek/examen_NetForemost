import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trainee/models/articulos_model.dart';

//* lo maneje asi por que es una simple peticion se podria separar los parametros a enviar
const String url =
    'https://newsapi.org/v2/top-headlines?country=us&apiKey=6ff70169fbe54cc687efb6f777b7c6e9';

class HomeProvider with ChangeNotifier {
  List<Articulo>? _noticiasFrescas;
  List<Articulo>? get getNoticiasFrescas => _noticiasFrescas;
  set setNoticiasFrescas(List<Articulo> noticiasNuevas) {
    _noticiasFrescas = noticiasNuevas;
    notifyListeners();
  }

  Future<void> getNoticias() async {
    final Uri urlPaseada = Uri.parse(url);
    try {
      final resp = await http.get(urlPaseada);
      if (resp.statusCode == 200 && resp.body.isNotEmpty) {
        final List<Articulo> listTemporalArticulso = [];
        //! revisar esta respuesta
        final Map<String, dynamic> noticiasRespuesta = json.decode(resp.body);
        //* Se que esto no es tan correcto tomar una propiedad del map peor lo hago por el tiempo perdon
        // print(noticiasRespuesta['articles'][1]);
        for (var noticia in noticiasRespuesta['articles']) {
          final temporalNoticia = Articulo.fromJson(noticia);
          // print(temporalNoticia.title);
          listTemporalArticulso.add(temporalNoticia);
        }
        // print(listTemporalArticulso);
        setNoticiasFrescas = listTemporalArticulso;
        return;
      } else {
        print('Respuesta no valida ${resp.statusCode}');
      }
    } catch (e) {
      print('Hubo un error $e');
    }
  }
}
