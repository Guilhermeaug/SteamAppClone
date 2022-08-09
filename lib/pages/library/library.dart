import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:steam_mobile/pages/library/game_section.dart';
import 'package:steam_mobile/pages/utils/drawer.dart';
import 'package:steam_mobile/steamapi/jabigod.dart';

import '../../models/game.dart';
import '../../steamapi/steam_client.dart';

final getIt = GetIt.instance;

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final SteamClient _client = getIt.get<SteamClient>();
  late Future<List<Game>> games;
  late final TextEditingController _controller;
  late SortBy _sortBy;

  @override
  void initState() {
    super.initState();
    games = _client.getOwnedGames();
    _controller = TextEditingController();
    _sortBy = SortBy.time;
  }

  TextStyle selectedStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  TextStyle linkStyle = const TextStyle(
    color: Colors.lightBlueAccent,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jogos',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                games = _client.getOwnedGames();
              });
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Image.network(jabigod.avatarMedium),
              const SizedBox(
                width: 8,
              ),
              Text(
                jabigod.personaName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const Text("  >> Jogos"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                'Filtrar jogos  ',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.black54,
                    filled: true,
                    hintText: 'Filtrar...',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  text: 'Ordenar por ',
                  children: [
                    TextSpan(
                      text: 'Tempo de jogo',
                      style: _sortBy == SortBy.time ? selectedStyle : linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (_sortBy != SortBy.time) {
                            setState(() {
                              _sortBy = SortBy.time;
                            });
                          }
                        },
                    ),
                    const TextSpan(text: '  '),
                    TextSpan(
                      text: 'Nome',
                      style: _sortBy == SortBy.name ? selectedStyle : linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (_sortBy != SortBy.name) {
                            setState(() {
                              _sortBy = SortBy.name;
                            });
                          }
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
          FutureBuilder<List<Game>>(
            future: games,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.hasData) {
                List<Game> games = snapshot.data!;
                games = games.where((game) {
                  return game.name.toLowerCase().contains(
                    _controller.text.toLowerCase(),
                  );
                }).toList();

                if (_sortBy == SortBy.time) {
                  games.sort(
                      (a, b) => b.playtimeForever.compareTo(a.playtimeForever));
                } else {
                  games.sort((a, b) => a.name.compareTo(b.name));
                }

                return ListView.builder(
                  itemCount: games.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Game game = games[index];
                    String url =
                        "https://cdn.cloudflare.steamstatic.com/steam/apps/${game.appId}/header.jpg";

                    return GameSection(
                      url: url,
                      name: game.name,
                      playtimeForever: game.playtimeForever,
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}

enum SortBy { time, name }
