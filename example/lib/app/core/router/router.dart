import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/main/view/main_view.dart';

///
/// for getting routers that are present in the app
///
final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: MainView.routeName,
      routes: [
        GoRoute(
          path: MainView.routeName,
          builder: (context, state) => const MainView(),
        ),
      ],
    );
  },
);
