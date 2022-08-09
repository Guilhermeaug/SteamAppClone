import 'package:flutter/material.dart';
import 'package:steam_mobile/steamapi/person_state.dart';

import '../../models/player_summary.dart';

class FriendSection extends StatelessWidget {
  final Iterable<PlayerSummary> players;
  final Color color;

  const FriendSection({
    Key? key,
    required this.players,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var player = players.elementAt(index);
        String playerStatus;
        if (player.gameExtraInfo != '') {
          playerStatus = player.gameExtraInfo!;
        } else {
          if (player.personaState != 0) {
            playerStatus = personState[player.personaState] ?? '';
          } else {
            playerStatus = "Última vez online: há ";
            DateTime lastLogoff =
                DateTime.fromMillisecondsSinceEpoch(player.lastLogoff * 1000);
            DateTime now = DateTime.now();
            int differenceInHours = now.difference(lastLogoff).inHours;
            int differenceInDays = now.difference(lastLogoff).inDays;

            if (differenceInDays > 365) {
              playerStatus += "mais de um ano";
            } else if (differenceInHours > 24) {
              playerStatus += (differenceInHours / 24).round().toString();
              if(differenceInHours < 48){
                playerStatus += " dia";
              } else {
                playerStatus += " dias";
              }
            } else {
              playerStatus += "$differenceInHours horas";
            }
          }
        }

        return InkWell(
          onTap: () {},
          child: Row(
            children: [
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                    width: 1,
                  ),
                  color: color,
                ),
                child: Image.network(player.avatar),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.personaName,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    playerStatus,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.chat,
                  color: Colors.grey,
                ),
                color: color,
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
