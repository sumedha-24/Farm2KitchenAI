import 'package:farm2kitchen/settings/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
//
import 'package:farm2kitchen/provider/app_state/app_state_provider.dart';
import 'package:farm2kitchen/settings/router/app_router.dart';
import 'package:farm2kitchen/screens/auth/provider/auth_state_provider.dart';

class MyApp extends StatefulWidget {
  late SharedPreferences prefs;
  int? onBoardCount;
  late final FirebaseAuth authInstance;

  MyApp(this.prefs, this.onBoardCount, this.authInstance, {Key? key})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppStateProvider appStateProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // appPermission = AppPermission();
    appStateProvider = AppStateProvider(
      widget.onBoardCount,
      widget.prefs,
      widget.authInstance,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthStateProvider()),
        ChangeNotifierProxyProvider<AuthStateProvider, AppStateProvider>(
          create: (context) => AppStateProvider(
            widget.onBoardCount,
            widget.prefs,
            Provider.of<AuthStateProvider>(context, listen: false).authInstance,
          ),
          update: (context, authState, appState) => AppStateProvider(
            widget.onBoardCount,
            widget.prefs,
            authState.authInstance,
          ),
        ),
        Provider(
          create: (context) => AppRouter(
            appStateProvider: appStateProvider,
            onBoardCount: widget.onBoardCount,
            prefs: widget.prefs,
          ),
        ),

      ],
      child: Builder(
        builder: ((context) {
          final GoRouter router = Provider.of<AppRouter>(context).router;

          return MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              theme: f2kTheme,
              darkTheme: ThemeData.dark(),
              routerDelegate: router.routerDelegate);
        }),
      ),
    );
  }
}
