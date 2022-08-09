import 'package:flutter/material.dart';
import 'package:steam_mobile/pages/home/home.dart';
import 'package:steam_mobile/pages/library/library.dart';

TextStyle style = const TextStyle(fontSize: 22, fontWeight: FontWeight.w300);

List<ListTile> createHeaderItems(BuildContext context) {
  return [
    ListTile(
      title: Text(
        "Steam Guard",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Confirmações",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Conversa",
        style: style,
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
    ),
    ListTile(
      title: Text(
        "Notificações",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Loja",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Comunidade",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Você e amigos",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Biblioteca",
        style: style,
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LibraryPage(),
          ),
        );
      },
    ),
    ListTile(
      title: Text(
        "Suporte",
        style: style,
      ),
      onTap: () {},
    ),
    ListTile(
      title: Text(
        "Configurações",
        style: style,
      ),
      onTap: () {},
    )
  ];
}
