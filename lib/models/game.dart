class Game {
  late final int appId;
  late final int playtime2Weeks;
  late final int playtimeForever;
  late final int playtimeWindowsForever;
  late final int playtimeMacForever;
  late final int playtimeLinuxForever;
  late final String name;
  late final String imgIconUrl;
  late final bool hasCommunityVisibleStats;
  late double? achievementsPercentage;

  Game({
    required this.appId,
    required this.playtime2Weeks,
    required this.playtimeForever,
    required this.playtimeWindowsForever,
    required this.playtimeMacForever,
    required this.playtimeLinuxForever,
    required this.name,
    required this.imgIconUrl,
    required this.hasCommunityVisibleStats,
    required this.achievementsPercentage,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        appId: json['appid'] ?? -1,
        playtime2Weeks: json['playtime_2weeks'] ?? -1,
        playtimeForever: json['playtime_forever'] ?? -1,
        playtimeWindowsForever: json['playtime_windows_forever'] ?? -1,
        playtimeMacForever: json['playtime_mac_forever'] ?? -1,
        playtimeLinuxForever: json['playtime_linux_forever'] ?? -1,
        name: json['name'] ?? '',
        imgIconUrl: json['img_icon_url'] ?? '',
        hasCommunityVisibleStats: json['has_community_visible_stats'] ?? false,
        achievementsPercentage: 0,
      );

  @override
  String toString() {
    return 'Game{name: $name}';
  }
}
