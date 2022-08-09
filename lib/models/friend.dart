class Friend {
  late final String steamId;
  late final String relationship;
  late final int friendSince;

  Friend({
    required this.steamId,
    required this.relationship,
    required this.friendSince,
  });

  Friend.fromJson(Map<String, dynamic> json)
      : steamId = json['steamid'],
        relationship = json['relationship'],
        friendSince = json['friend_since'];

  @override
  String toString() {
    return 'Friend{steamId: $steamId, relationship: $relationship, friendSince: $friendSince}';
  }
}
