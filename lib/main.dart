import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import './providers/auth.dart';
import './providers/products.dart';
import './screens/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products(),
            update: (ctx, auth, previousProducts) =>
                previousProducts..setUser = auth.user),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          darkTheme: ThemeData(
              primarySwatch: Colors.grey,
              accentColor: Colors.black,
              colorScheme: ColorScheme.dark()),
          theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
          ),
          home: auth.isSignIn
              ? MyHomePage(title: 'Combat Covid')
              : auth.signingInFirstTime
                  ? Scaffold(
                      body: Center(
                        child: Container(
                          width: 200,
                          child: ListTile(
                            title: const Text("Signing you in"),
                            trailing: const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : FutureBuilder<bool>(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) {
                        print(authResultSnapshot.connectionState);
                        return authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Scaffold(
                                body: Center(
                                  child: Container(
                                    width: 150,
                                    child: ListTile(
                                      title: const Text("Loading"),
                                      trailing: const CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SignIn();
                      }),
        ),
      ),
    );
  }
}
