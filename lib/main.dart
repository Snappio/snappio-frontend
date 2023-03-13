import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/provider/user_provider.dart';
import 'package:snappio_frontend/router.dart';
import 'package:snappio_frontend/screens/chat_section.dart';
import 'package:snappio_frontend/services/auth_services.dart';
import 'package:snappio_frontend/themes.dart';
import 'package:snappio_frontend/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: "Snappio",
        themeMode: ThemeMode.system,
        theme: Themes.lightMode(context),
        darkTheme: Themes.darkMode(context),
        onGenerateRoute: (settings) => generateRoute(settings),
        initialRoute: '/splashScreen',
      ),
    );
  }
}
