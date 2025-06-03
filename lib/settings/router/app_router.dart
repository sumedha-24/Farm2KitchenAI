import 'package:farm2kitchen/provider/app_state/app_state_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:farm2kitchen/screens/auth/auth_screen.dart';
import 'package:farm2kitchen/screens/auction/auctionhome.dart';
import 'package:farm2kitchen/screens/form/form.dart';

import 'package:farm2kitchen/screens/onboard/onboard_screen.dart';
import 'package:go_router/go_router.dart';
import 'utils/router_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

class AppRouter {
  late AppStateProvider appStateProvider;
  late SharedPreferences prefs;
  // final FirebaseAuth authInstance;
  int? onBoardCount;

  AppRouter({
    required this.appStateProvider,
    required this.onBoardCount,
    required this.prefs,
    // required this.authInstance
  });
  get router => _router;

  late final _router = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          routes: [],
          builder: (context, state) =>  const FormApp(),
        ),
        GoRoute(
          path: APP_PAGE.auth.routePath,
          name: APP_PAGE.auth.routeName,
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: APP_PAGE.auction.routePath,
          name: APP_PAGE.auction.routeName,
          builder: (context, state) => AuctionHome(),
        ),
        GoRoute(
            path: APP_PAGE.onboard.routePath,
            name: APP_PAGE.onboard.routeName,
            builder: (context, state) => const OnBoardScreen()),

      ],
      redirect: (state) {
        final String onboardLocation =
            state.namedLocation(APP_PAGE.onboard.routeName);

        final String authLocation =
            state.namedLocation(APP_PAGE.auth.routeName);

        bool isOnboarding = state.subloc == onboardLocation;
        bool isLogginIn = state.subloc == authLocation;

        bool? toOnboard = prefs.containsKey('onBoardKey') ? false : true;
        // bool? isLoggedIn = authInstance.currentUser != null ? true : false;
        bool? isLoggedIn =
            appStateProvider.auth.currentUser == null ? false : true;

        print("Is LoggedIn is $isLoggedIn");
        if (toOnboard) {
          // onBoardCount = 0;
          return isOnboarding ? null : onboardLocation;
        } else if (!isLoggedIn) {
          return isLogginIn ? null : authLocation;
        }

        return null;
      });
}
