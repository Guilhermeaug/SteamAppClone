import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:steam_mobile/pages/home/home.dart';
import 'package:steam_mobile/steamapi/steam_client.dart';

final getIt = GetIt.instance;

void main() async {
  await dotenv.load(fileName: ".env");
  getIt.registerSingleton<SteamClient>(SteamClient());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const MaterialColor materialColor =
      MaterialColor(0xff1B2838, <int, Color>{
    50: Color(0xffE4E5E7),
    100: Color(0xffBBBFC3),
    200: Color(0xff8D949C),
    300: Color(0xff5F6974),
    400: Color(0xff3D4856),
    500: Color(0xff1B2838),
    600: Color(0xff182432),
    700: Color(0xff141E2B),
    800: Color(0xff101824),
    900: Color(0xff080F17),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steam Mobile',
      theme: ThemeData(
          primarySwatch: materialColor,
          scaffoldBackgroundColor: const Color(0xff1B2838),
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          )),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
