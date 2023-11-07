import 'package:go_router/go_router.dart';

import '../../screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: ListNoticiasPage.routerName,
      path: '/',
      builder: (context, state) => const ListNoticiasPage(),
    ),
    GoRoute(
      name: NoticiaPage.routerName,
      path: '/Noticia_page',
      builder: (context, state) => const NoticiaPage(),
    ),
  ],
);
