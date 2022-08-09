import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/friend.dart';
import '../models/game.dart';
import '../models/player_summary.dart';

class SteamClient extends http.BaseClient {
  final http.Client _client = http.Client();
  final String _baseUrl = 'api.steampowered.com';
  final String _steamId = "76561198077856068";
  final Map<String, String> headers = {
    'Content-type': 'urlencoded',
    'Accept': 'application/json',
    'User-Agent': 'Flutter SteamAPI Client clone',
  };

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll(headers);
    return _client.send(request);
  }

  Future<List<Friend>> getFriendList() async {
    final Map<String, String> queryParameters = {
      'key': dotenv.get('STEAM_KEY'),
      'steamid': _steamId,
      'relationship': 'friend',
    };
    final url =
        Uri.https(_baseUrl, '/ISteamUser/GetFriendList/v0001', queryParameters);

    final request = http.Request('GET', url);
    final response = await send(request);

    if (response.statusCode == 200) {
      var body = await http.Response.fromStream(response);
      var json = jsonDecode(body.body);
      var friends = json['friendslist']['friends'] as List;
      return friends.map((friend) => Friend.fromJson(friend)).toList();
    } else {
      throw Exception('Failed to get friend list');
    }
  }

  Future<List<PlayerSummary>> getPlayerSummaries() async {
    List<Friend> friends = await getFriendList();
    String steamIds = friends.map((friend) => friend.steamId).join(',');

    final Map<String, String> queryParameters = {
      'key': dotenv.get('STEAM_KEY'),
      'steamids': steamIds,
    };
    final url = Uri.https(
        _baseUrl, '/ISteamUser/GetPlayerSummaries/v0002', queryParameters);

    final request = http.Request('GET', url);
    final response = await send(request);

    if (response.statusCode == 200) {
      var body = await http.Response.fromStream(response);
      var json = jsonDecode(body.body);
      var players = json['response']['players'] as List;
      return players.map((player) => PlayerSummary.fromJson(player)).toList();
    } else {
      throw Exception('Failed to get player summaries');
    }
  }

  Future<List<Game>> getOwnedGames() async {
    final Map<String, dynamic> queryParameters = {
      'key': dotenv.get('STEAM_KEY'),
      'steamid': _steamId,
      'include_appinfo': 'true',
      'include_played_free_games': 'true',
    };
    final url = Uri.https(
        _baseUrl, '/IPlayerService/GetOwnedGames/v0001', queryParameters);

    final request = http.Request('GET', url);
    final response = await send(request);

    if (response.statusCode == 200) {
      var body = await http.Response.fromStream(response);
      var json = jsonDecode(body.body);
      var games = json['response']['games'] as List;

      return games.map((game) {
        return Game.fromJson(game);
      }).toList();
    } else {
      throw Exception('Failed to games information');
    }
  }
}
