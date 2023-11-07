import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trainee/models/articulos_model.dart';
import 'package:trainee/screens/providers.dart';

class NoticiaPage extends StatelessWidget {
  static const String routerName = 'Noticia_page';

  const NoticiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Articulo articulo =
        Provider.of<NoticiaPageProvider>(context, listen: false).getArticulo!;
    String? autores;
    if (articulo.author != null) {
      final List<String> listAutores = articulo.author!.split(',');
      if (listAutores.length > 5) {
        autores = '';
        for (int i = 0; i < 5; i++) {
          autores = '$autores, ${listAutores[i]}';
        }
      } else {
        autores = articulo.author;
      }
    }

    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: const Padding(
              padding: EdgeInsets.only(left: 20, top: 22, bottom: 22),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          (articulo.urlToImage == null)
              ? Image.asset('assets/SIN-IMAGEN.jpg')
              : Image.network(articulo.urlToImage!),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    articulo.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (autores == null)
                            ? const Spacer()
                            : Flexible(child: Text(autores)),
                        Column(
                          children: [
                            Text(
                                '${articulo.publishedAt.month} ${articulo.publishedAt.day}, ${articulo.publishedAt.year}'),
                            Text(
                                '${articulo.publishedAt.hour} : ${articulo.publishedAt.minute}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  (articulo.content == null)
                      ? const SizedBox()
                      : Text(
                          articulo.content!,
                          style: const TextStyle(fontSize: 19),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
