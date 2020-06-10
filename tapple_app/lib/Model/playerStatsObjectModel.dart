

class PlayerStatsObject {
  final bool success;
  final PlayerStatsResponse response;

  PlayerStatsObject({this.response, this.success});

  factory PlayerStatsObject.fromJson(Map<String, dynamic> json) {
    return PlayerStatsObject(
      success: json['date'] as bool,
      response: PlayerStatsResponse.fromJson(json['response']),
    );
  }
}

class PlayerStatsResponse {
  final String id;
  final String username;
  final String discriminator;
  final String uuid;
  final int totalxp;
  final String name;
  final int timestampFirstJoined;
  final int timeplayedMiliseconds;


  final int casualWins;
  final int casualLosses;
  final int casualKills;
  final int casualDeaths;
  final int casualWinstreak;
  final int casualBestWinstreak;

  final int competitiveWins;
  final int competitiveLosses;
  final int competitiveKills;
  final int competitiveDeaths;
  final int competitiveWinstreak;
  final int competitiveBestWinstreak;


  final int builduhcCasualWins;
  final int builduhcCasualLosses;
  final int builduhcCasualKills;
  final int builduhcCasualDeaths;
  final int builduhcCasualWinstreak;
  final int builduhcCasualBestWinstreak;

  final int builduhcCompetitiveWins;
  final int builduhcCompetitiveLosses;
  final int builduhcCompetitiveKills;
  final int builduhcCompetitiveDeaths;
  final int builduhcCompetitiveWinstreak;
  final int builduhcCompetitiveBestWinstreak;


  final int archerCasualWins;
  final int archerCasualLosses;
  final int archerCasualKills;
  final int archerCasualDeaths;
  final int archerCasualWinstreak;
  final int archerCasualBestWinstreak;

  final int archerCompetitiveWins;
  final int archerCompetitiveLosses;
  final int archerCompetitiveKills;
  final int archerCompetitiveDeaths;
  final int archerCompetitiveWinstreak;
  final int archerCompetitiveBestWinstreak;


  final int potionCasualWins;
  final int potionCasualLosses;
  final int potionCasualKills;
  final int potionCasualDeaths;
  final int potionCasualWinstreak;
  final int potionCasualBestWinstreak;

  final int potionCompetitiveWins;
  final int potionCompetitiveLosses;
  final int potionCompetitiveKills;
  final int potionCompetitiveDeaths;
  final int potionCompetitiveWinstreak;
  final int potionCompetitiveBestWinstreak;


  final int parkourCasualWins;
  final int parkourCasualLosses;
  final int parkourCasualKills;
  final int parkourCasualDeaths;
  final int parkourCasualWinstreak;
  final int parkourCasualBestWinstreak;
  final int parkourCompetitiveWins;
  final int parkourCompetitiveLosses;
  final int parkourCompetitiveKills;
  final int parkourCompetitiveDeaths;
  final int parkourCompetitiveWinstreak;
  final int parkourCompetitiveBestWinstreak;


  final int comboCasualWins;
  final int comboCasualLosses;
  final int comboCasualKills;
  final int comboCasualDeaths;
  final int comboCasualWinstreak;
  final int comboCasualBestWinstreak;


  final int sgCasualWins;
  final int sgCasualLosses;
  final int sgCasualKills;
  final int sgCasualDeaths;
  final int sgCasualWinstreak;
  final int sgCasualBestWinstreak;


  final int skywarsCasualWins;
  final int skywarsCasualLosses;
  final int skywarsCasualKills;
  final int skywarsCasualDeaths;
  final int skywarsCasualWinstreak;
  final int skywarsCasualBestWinstreak;


  final int soupCasualWins;
  final int soupCasualLosses;
  final int soupCasualKills;
  final int soupCasualDeaths;
  final int soupCasualWinstreak;
  final int soupCasualBestWinstreak;


  final int sumoCasualWins;
  final int sumoCasualLosses;
  final int sumoCasualKills;
  final int sumoCasualDeaths;
  final int sumoCasualWinstreak;
  final int sumoCasualBestWinstreak;


  final int spleefCasualWins;
  final int spleefCasualLosses;
  final int spleefCasualKills;
  final int spleefCasualDeaths;
  final int spleefCasualWinstreak;
  final int spleefCasualBestWinstreak;


  final int horseCasualWins;
  final int horseCasualLosses;
  final int horseCasualKills;
  final int horseCasualDeaths;
  final int horseCasualWinstreak;
  final int horseCasualBestWinstreak;

  PlayerStatsResponse({this.id, this.username, this.discriminator, this.uuid, this.totalxp, this.name, this.timeplayedMiliseconds, this.timestampFirstJoined,
    this.builduhcCasualBestWinstreak, this.builduhcCasualDeaths, this.builduhcCasualKills, this.builduhcCasualLosses, this.builduhcCasualWins, this.builduhcCasualWinstreak,
    this.builduhcCompetitiveBestWinstreak, this.builduhcCompetitiveDeaths, this.builduhcCompetitiveKills, this.builduhcCompetitiveLosses, this.builduhcCompetitiveWins,
    this.builduhcCompetitiveWinstreak, this.archerCasualBestWinstreak, this.archerCasualDeaths, this.archerCasualKills, this.archerCasualLosses, this.archerCasualWins, this.archerCasualWinstreak,
    this.archerCompetitiveBestWinstreak, this.archerCompetitiveDeaths, this.archerCompetitiveKills, this.archerCompetitiveLosses,this.archerCompetitiveWins,
    this.archerCompetitiveWinstreak, this.casualBestWinstreak,this.casualDeaths,this.casualKills,this.casualLosses,this.casualWins,this.casualWinstreak,
    this.comboCasualBestWinstreak,this.comboCasualDeaths,this.comboCasualKills,this.comboCasualLosses,this.comboCasualWins,this.comboCasualWinstreak,this.competitiveBestWinstreak,this.competitiveDeaths,
    this.competitiveKills,this.competitiveLosses,this.competitiveWins,this.competitiveWinstreak,this.horseCasualBestWinstreak,this.horseCasualDeaths,this.horseCasualKills,
    this.horseCasualLosses,this.horseCasualWins,this.horseCasualWinstreak,this.parkourCasualBestWinstreak,this.parkourCasualDeaths,this.parkourCasualKills,
    this.parkourCasualLosses,this.parkourCasualWins,this.parkourCasualWinstreak,this.parkourCompetitiveBestWinstreak,this.parkourCompetitiveDeaths,this.parkourCompetitiveKills,
    this.parkourCompetitiveLosses,this.parkourCompetitiveWins,this.parkourCompetitiveWinstreak,this.potionCasualBestWinstreak,this.potionCasualDeaths,
    this.potionCasualKills,this.potionCasualLosses,this.potionCasualWins,this.potionCasualWinstreak,this.potionCompetitiveBestWinstreak,this.potionCompetitiveDeaths,
    this.potionCompetitiveKills,this.potionCompetitiveLosses,this.potionCompetitiveWins,this.potionCompetitiveWinstreak,this.sgCasualBestWinstreak,
    this.sgCasualDeaths,this.sgCasualKills,this.sgCasualLosses,this.sgCasualWins,this.sgCasualWinstreak,this.skywarsCasualBestWinstreak,
    this.skywarsCasualDeaths,this.skywarsCasualKills,this.skywarsCasualLosses,this.skywarsCasualWins,this.skywarsCasualWinstreak,
    this.soupCasualBestWinstreak,this.soupCasualDeaths,this.soupCasualKills,this.soupCasualLosses,this.soupCasualWins,this.soupCasualWinstreak,
    this.spleefCasualBestWinstreak,this.spleefCasualDeaths,this.spleefCasualKills,this.spleefCasualLosses,this.spleefCasualWins,this.spleefCasualWinstreak,
    this.sumoCasualBestWinstreak,this.sumoCasualDeaths,this.sumoCasualKills,this.sumoCasualLosses,this.sumoCasualWins,this.sumoCasualWinstreak
  });

  factory PlayerStatsResponse.fromJson(Map<String, dynamic> json) {
    return PlayerStatsResponse(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      discriminator: json['discriminator'] as String,
      totalxp: json['totalxp'] as int,
      uuid: json['uuid'] as String,
      timeplayedMiliseconds: json['timeplayedMiliseconds'] as int,
      timestampFirstJoined: json['timestampFirstJoined'] as int,
      casualBestWinstreak: json['casualBestWinstreak'] as int,
      casualDeaths: json['casualDeaths'] as int,
      casualKills: json['casualKills'] as int,
      casualLosses: json['casualLosses'] as int,
      casualWins: json['casualWins'] as int,
      casualWinstreak: json['competitiveWinstreak'] as int,
      competitiveBestWinstreak: json['competitiveBestWinstreak'] as int,
      competitiveDeaths: json['competitiveDeaths'] as int,
      competitiveKills: json['competitiveKills'] as int,
      competitiveLosses: json['competitiveLosses'] as int,
      competitiveWins: json['competitiveWins'] as int,
      competitiveWinstreak: json['competitiveWinstreak'] as int,


      builduhcCasualWins: json['builduhc-casual-wins'] as int,
      builduhcCasualLosses: json['builduhc-casual-losses'] as int,
      builduhcCasualKills: json['builduhc-casual-kills'] as int,
      builduhcCasualDeaths: json['builduhc-casual-deaths'] as int,
      builduhcCasualWinstreak: json['builduhc-casual-winstreak'] as int,
      builduhcCasualBestWinstreak: json['builduhc-casual-best-winstreak'] as int,
      builduhcCompetitiveWins: json['builduhc-competitive-wins'] as int,
      builduhcCompetitiveLosses: json['builduhc-competitive-losses'] as int,
      builduhcCompetitiveKills: json['builduhc-competitive-kills'] as int,
      builduhcCompetitiveDeaths: json['builduhc-competitive-deaths'] as int,
      builduhcCompetitiveWinstreak: json['builduhc-competitive-winstreak'] as int,
      builduhcCompetitiveBestWinstreak: json['builduhc-competitive-best-winstreak'] as int,
      archerCasualWins: json['archer-casual-wins'] as int,
      archerCasualLosses: json['archer-casual-losses'] as int,
      archerCasualKills: json['archer-casual-kills'] as int,
      archerCasualDeaths: json['archer-casual-deaths'] as int,
      archerCasualWinstreak: json['archer-casual-winstreak'] as int,
      archerCasualBestWinstreak: json['archer-casual-best-winstreak'] as int,
      archerCompetitiveWins: json['archer-competitive-wins'] as int,
      archerCompetitiveLosses: json['archer-competitive-losses'] as int,
      archerCompetitiveKills: json['archer-competitive-kills'] as int,
      archerCompetitiveDeaths: json['archer-competitive-deaths'] as int,
      archerCompetitiveWinstreak: json['archer-competitive-winstreak'] as int,
      archerCompetitiveBestWinstreak: json['archer-competitive-best-winstreak'] as int,
      potionCasualWins: json['potion-casual-wins'] as int,
      potionCasualLosses: json['potion-casual-losses'] as int,
      potionCasualKills: json['potion-casual-kills'] as int,
      potionCasualDeaths: json['potion-casual-deaths'] as int,
      potionCasualWinstreak: json['potion-casual-winstreak'] as int,
      potionCasualBestWinstreak: json['potion-casual-best-winstreak'] as int,
      potionCompetitiveWins: json['potion-competitive-wins'] as int,
      potionCompetitiveLosses: json['potion-competitive-losses'] as int,
      potionCompetitiveKills: json['potion-competitive-kills'] as int,
      potionCompetitiveDeaths: json['potion-competitive-deaths'] as int,
      potionCompetitiveWinstreak: json['potion-competitive-winstreak'] as int,
      potionCompetitiveBestWinstreak: json['potion-competitive-best-winstreak'] as int,
      comboCasualWins: json['combo-casual-wins'] as int,
      comboCasualLosses: json['combo-casual-losses'] as int,
      comboCasualKills: json['combo-casual-kills'] as int,
      comboCasualDeaths: json['combo-casual-deaths'] as int,
      comboCasualWinstreak: json['combo-casual-winstreak'] as int,
      comboCasualBestWinstreak: json['combo-casual-best-winstreak'] as int,
      sgCasualWins: json['sg-casual-wins'] as int,
      sgCasualLosses: json['sg-casual-losses'] as int,
      sgCasualKills: json['sg-casual-kills'] as int,
      sgCasualDeaths: json['sg-casual-deaths'] as int,
      sgCasualWinstreak: json['sg-casual-winstreak'] as int,
      sgCasualBestWinstreak: json['sg-casual-best-winstreak'] as int,
      skywarsCasualWins: json['skywars-casual-wins'] as int,
      skywarsCasualLosses: json['skywars-casual-losses'] as int,
      skywarsCasualKills: json['skywars-casual-kills'] as int,
      skywarsCasualDeaths: json['skywars-casual-deaths'] as int,
      skywarsCasualWinstreak: json['skywars-casual-winstreak'] as int,
      skywarsCasualBestWinstreak: json['skywars-casual-best-winstreak'] as int,
      soupCasualWins: json['soup-casual-wins'] as int,
      soupCasualLosses: json['soup-casual-losses'] as int,
      soupCasualKills: json['soup-casual-kills'] as int,
      soupCasualDeaths: json['soup-casual-deaths'] as int,
      soupCasualWinstreak: json['soup-casual-winstreak'] as int,
      soupCasualBestWinstreak: json['soup-casual-best-winstreak'] as int,
      parkourCasualWins: json['parkour-casual-wins'] as int,
      parkourCasualLosses: json['parkour-casual-losses'] as int,
      parkourCasualKills: json['parkour-casual-kills'] as int,
      parkourCasualDeaths: json['parkour-casual-deaths'] as int,
      parkourCasualWinstreak: json['parkour-casual-winstreak'] as int,
      parkourCasualBestWinstreak: json['parkour-casual-best-winstreak'] as int,
      parkourCompetitiveWins: json['parkour-competitive-wins'] as int,
      parkourCompetitiveLosses: json['parkour-competitive-losses'] as int,
      parkourCompetitiveKills: json['parkour-competitive-kills'] as int,
      parkourCompetitiveDeaths: json['parkour-competitive-deaths'] as int,
      parkourCompetitiveWinstreak: json['parkour-competitive-winstreak'] as int,
      parkourCompetitiveBestWinstreak: json['parkour-competitive-best-winstreak'] as int,
      sumoCasualWins: json['sumo-casual-wins'] as int,
      sumoCasualLosses: json['sumo-casual-losses'] as int,
      sumoCasualKills: json['sumo-casual-kills'] as int,
      sumoCasualDeaths: json['sumo-casual-deaths'] as int,
      sumoCasualWinstreak: json['sumo-casual-winstreak'] as int,
      sumoCasualBestWinstreak: json['sumo-casual-best-winstreak'] as int,
      spleefCasualWins: json['spleef-casual-wins'] as int,
      spleefCasualLosses: json['spleef-casual-losses'] as int,
      spleefCasualKills: json['spleef-casual-kills'] as int,
      spleefCasualDeaths: json['spleef-casual-deaths'] as int,
      spleefCasualWinstreak: json['spleef-casual-winstreak'] as int,
      spleefCasualBestWinstreak: json['spleef-casual-best-winstreak'] as int,
      horseCasualWins: json['horse-casual-wins'] as int,
      horseCasualLosses: json['horse-casual-losses'] as int,
      horseCasualKills: json['horse-casual-kills'] as int,
      horseCasualDeaths: json['horse-casual-deaths'] as int,
      horseCasualWinstreak: json['horse-casual-winstreak'] as int,
      horseCasualBestWinstreak: json['horse-casual-best-winstreak'] as int,

    );
  }

}

