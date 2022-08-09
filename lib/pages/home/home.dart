import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:steam_mobile/pages/home/section_divider.dart';
import 'package:steam_mobile/steamapi/steam_client.dart';

import '../../models/player_summary.dart';
import '../utils/drawer.dart';
import 'friend_section.dart';

final getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SteamClient _client = getIt.get<SteamClient>();
  late Future<List<PlayerSummary>> playerSummaries;

  late final TextEditingController _searchController;

  bool showSearchIcon = false;
  bool showRefreshIcon = true;

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text(
    'Amigos',
    style: TextStyle(
      fontWeight: FontWeight.w400,
    ),
  );

  @override
  void initState() {
    super.initState();
    playerSummaries = _client.getPlayerSummaries();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isEmpty) {
          showSearchIcon = true;
        } else {
          showSearchIcon = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Visibility(
              visible: showSearchIcon && !showRefreshIcon,
              child: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            customSearchBar
          ],
        ),
        actions: [
          IconButton(
            icon: customIcon,
            color: Colors.grey,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  activateSearch();
                } else {
                  if (_searchController.text.isNotEmpty) {
                    _searchController.clear();
                  } else {
                    defaultAppBar();
                  }
                }
              });
            },
          ),
          Visibility(
            visible: showRefreshIcon,
            child: IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.grey,
              onPressed: () {
                setState(() {
                  playerSummaries = _client.getPlayerSummaries();
                });
              },
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder<List<PlayerSummary>>(
        future: playerSummaries,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            List<PlayerSummary> playerSummaries = snapshot.data!;
            playerSummaries = playerSummaries.where((summary) {
              return summary.personaName.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  );
            }).toList();
            var inGamePlayers =
                playerSummaries.where((element) => element.gameId != '');
            var onlinePlayers = playerSummaries.where(
                (element) => element.personaState != 0 && element.gameId == '');
            var offlinePlayers = playerSummaries.where(
                (element) => element.personaState == 0 && element.gameId == '');

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 2),
              children: [
                if (inGamePlayers.isNotEmpty)
                  const SectionDivider(description: 'EM JOGO'),
                FriendSection(
                  players: inGamePlayers,
                  color: const Color(0xFF5DAF06),
                ),
                if (onlinePlayers.isNotEmpty)
                  const SectionDivider(description: 'ONLINE'),
                FriendSection(
                  players: onlinePlayers,
                  color: const Color(0xFF2DAEDE),
                ),
                if (offlinePlayers.isNotEmpty)
                  const SectionDivider(description: 'OFFLINE'),
                FriendSection(
                  players: offlinePlayers,
                  color: Colors.grey,
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void defaultAppBar() {
    customIcon = const Icon(Icons.search);
    showRefreshIcon = true;
    customSearchBar = const Text(
      'Amigos',
      style: TextStyle(
        fontWeight: FontWeight.w400,
      ),
    );
  }

  void activateSearch() {
    customIcon = const Icon(Icons.close);
    showRefreshIcon = false;

    customSearchBar = Stack(
      alignment: Alignment.centerLeft,
      children: [
        TextField(
          autofocus: true,
          controller: _searchController,
          style: const TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
