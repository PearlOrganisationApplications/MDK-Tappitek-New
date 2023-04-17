// To parse this JSON data, do
//
//     final socialMediaapps = socialMediaappsFromJson(jsonString);

import 'dart:convert';

SocialMediaapps socialMediaappsFromJson(String str) => SocialMediaapps.fromJson(json.decode(str));

String socialMediaappsToJson(SocialMediaapps data) => json.encode(data.toJson());

class SocialMediaapps {
  SocialMediaapps({
    required this.socialMedia,
    required this.portfolio,
    required this.music,
    required this.business,
    required this.others,
  });

  List<Music> socialMedia;
  List<Music> portfolio;
  List<Music> music;
  List<dynamic> business;
  List<dynamic> others;

  factory SocialMediaapps.fromJson(Map<String, dynamic> json) => SocialMediaapps(
    socialMedia: List<Music>.from(json["SocialMedia"].map((x) => Music.fromJson(x))),
    portfolio: List<Music>.from(json["Portfolio"].map((x) => Music.fromJson(x))),
    music: List<Music>.from(json["Music"].map((x) => Music.fromJson(x))),
    business: List<dynamic>.from(json["Business"].map((x) => x)),
    others: List<dynamic>.from(json["Others"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "SocialMedia": List<dynamic>.from(socialMedia.map((x) => x.toJson())),
    "Portfolio": List<dynamic>.from(portfolio.map((x) => x.toJson())),
    "Music": List<dynamic>.from(music.map((x) => x.toJson())),
    "Business": List<dynamic>.from(business.map((x) => x)),
    "Others": List<dynamic>.from(others.map((x) => x)),
  };
}

class Music {
  Music({
    required this.id,
    required this.appname,
    required this.url,
    required this.icon,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.iconImage,
  });

  int id;
  String appname;
  String url;
  String icon;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  String iconImage;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
    id: json["id"],
    appname: json["appname"],
    url: json["url"],
    icon: json["icon"],
    category: json["category"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    iconImage: json["icon_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appname": appname,
    "url": url,
    "icon": icon,
    "category": category,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "icon_image": iconImage,
  };
}
