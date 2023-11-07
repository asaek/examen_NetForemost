import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trainee/models/articulos_model.dart';
import 'package:trainee/screens/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class ListNoticiasPage extends StatefulWidget {
  static const String routerName = '/';

  const ListNoticiasPage({super.key});

  @override
  State<ListNoticiasPage> createState() => _ListNoticiasPageState();
}

class _ListNoticiasPageState extends State<ListNoticiasPage> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).getNoticias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'NetForemost News',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Selector<HomeProvider, List<Articulo>?>(
                selector: (context, homeProvider) =>
                    homeProvider.getNoticiasFrescas,
                builder: (context, noticiasFrescas, _) {
                  return (noticiasFrescas == null)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: noticiasFrescas.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            String? autoresRecortados;
                            if (noticiasFrescas[index].author != null) {
                              final List<String> autoresListSeparada =
                                  noticiasFrescas[index].author!.split(',');

                              if (autoresListSeparada.length > 2) {
                                autoresRecortados = '';
                                for (int i = 0; i < 2; i++) {
                                  autoresRecortados =
                                      '${autoresRecortados!},${autoresListSeparada[i]}';
                                }
                              } else {
                                autoresRecortados =
                                    noticiasFrescas[index].author;
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 30,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Provider.of<NoticiaPageProvider>(context,
                                          listen: false)
                                      .setArticulo = noticiasFrescas[index];
                                  context.push('/Noticia_page');
                                },
                                child: SizedBox(
                                  height: 200,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: SizedBox(
                                          width: 160,
                                          height: double.infinity,
                                          child: (noticiasFrescas[index]
                                                      .urlToImage ==
                                                  null)
                                              ? Image.asset(
                                                  'assets/SIN-IMAGEN.jpg')
                                              : Image.network(
                                                  noticiasFrescas[index]
                                                      .urlToImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              noticiasFrescas[index].title,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              autoresRecortados ?? '',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 109, 109, 109),
                                                fontSize: 13,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                final urlPaser = Uri.parse(
                                                    noticiasFrescas[index].url);

                                                if (await canLaunchUrl(
                                                    urlPaser)) {
                                                  launchUrl(urlPaser,
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }
                                              },
                                              child: Text(
                                                noticiasFrescas[index]
                                                    .source
                                                    .name,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 88, 156, 209),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${noticiasFrescas[index].publishedAt.month} ${noticiasFrescas[index].publishedAt.day}, ${noticiasFrescas[index].publishedAt.year}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 32, 32, 32),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Icon(Icons.more_horiz),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
