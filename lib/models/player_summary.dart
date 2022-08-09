class PlayerSummary {
  late final String steamId;
  late final int communityVisibilityState;
  late final int profileState;
  late final String personaName;
  late final String profileUrl;
  late final String avatar;
  late final String avatarMedium;
  late final String avatarFull;
  late final String avatarHash;
  late final int lastLogoff;
  late final int personaState;
  late final String? realName;
  late final String? primaryClanId;
  late final int? timeCreated;
  late final int personaStateFlags;
  late final String? locCountryCode;
  late final String locStateCode;
  late final int? locCityId;
  late final String? gameId;
  late final String? gameExtraInfo;
  late final int? cityId;

  PlayerSummary({
    required this.steamId,
    required this.communityVisibilityState,
    required this.profileState,
    required this.personaName,
    required this.profileUrl,
    required this.avatar,
    required this.avatarMedium,
    required this.avatarFull,
    required this.avatarHash,
    required this.lastLogoff,
    required this.personaState,
    this.realName,
    this.primaryClanId,
    this.timeCreated,
    required this.personaStateFlags,
    this.locCountryCode,
    required this.locStateCode,
    this.locCityId,
    this.gameId,
    this.gameExtraInfo,
    this.cityId,
  });

  factory PlayerSummary.fromJson(Map<String, dynamic> json) => PlayerSummary(
        steamId: json['steamid'] ?? '',
        communityVisibilityState: json['communityvisibilitystate'] ?? 0,
        profileState: json['profilestate'] ?? 0,
        personaName: json['personaname'] ?? '',
        profileUrl: json['profileurl'] ?? '',
        avatar: json['avatar'] ?? '',
        avatarMedium: json['avatarmedium'] ?? '',
        avatarFull: json['avatarfull'] ?? '',
        avatarHash: json['avatarhash'] ?? '',
        lastLogoff: json['lastlogoff'] ?? 0,
        personaState: json['personastate'] ?? 0,
        realName: json['realname'] ?? '',
        primaryClanId: json['primaryclanid'] ?? '',
        timeCreated: json['timecreated'] ?? 0,
        personaStateFlags: json['personastateflags'] ?? 0,
        locCountryCode: json['loccountrycode'] ?? '',
        locStateCode: json['locstatecode'] ?? '',
        locCityId: json['loccityid'] ?? 0,
        gameId: json['gameid'] ?? '',
        gameExtraInfo: json['gameextrainfo'] ?? '',
        cityId: json['cityid'] ?? 0,
      );

  @override
  String toString() {
    return 'PlayerSummary{steamId: $steamId, communityVisibilityState: $communityVisibilityState, profileState: $profileState, personaName: $personaName, profileUrl: $profileUrl, avatar: $avatar, avatarMedium: $avatarMedium, avatarFull: $avatarFull, avatarHash: $avatarHash, lastLogoff: $lastLogoff, personaState: $personaState, realName: $realName, primaryClanId: $primaryClanId, timeCreated: $timeCreated, personaStateFlags: $personaStateFlags, locCountryCode: $locCountryCode, locStateCode: $locStateCode, locCityId: $locCityId, gameId: $gameId, cityId: $cityId}';
  }
}
