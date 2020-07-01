
class LeaderboardsObject {
  final bool success;
  final List<LeaderboardsResponse> leaderboard;

  LeaderboardsObject([this.leaderboard, this.success]);

  factory LeaderboardsObject.fromJson(dynamic json) {
    var tagObjsJson = json['leaderboard'] as List;
    List<LeaderboardsResponse> _tags = tagObjsJson.map((tagJson) => LeaderboardsResponse.fromJson(tagJson))
        .toList();
    return LeaderboardsObject(
      _tags,
      json['date'] as bool,
    );
  }
}

class LeaderboardsResponse {
  final String uuid;
  final String username;
  final String rank;
  final String xp;
  final int position;

  LeaderboardsResponse(this.rank,this.username,this.position,this.uuid,this.xp);

  factory LeaderboardsResponse.fromJson(Map<String, dynamic> json) {
    return LeaderboardsResponse(
      json['rank'] as String,
      json['username'] as String,
      json['position'] as int,
      json['uuid'] as String,
      json['xp'] as String,
    );
  }
}