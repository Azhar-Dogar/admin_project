class SongModel {
  String? id;
  late String title;
  late String city;
  late String genre;
  late String posterUrl;
  late String songUrl;
  late DateTime createdAt;
  late DateTime updatedAt;
  late bool isLive;
  late String bandId;

  SongModel({
    this.id,
    required this.title,
    required this.city,
    required this.createdAt,
    required this.genre,
    required this.posterUrl,
    required this.songUrl,
    required this.updatedAt,
    required this.bandId,
    this.isLive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "city": city,
      "genre": genre,
      "bandId" : bandId,
      "posterUrl": posterUrl,
      "songUrl": songUrl,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "updatedAt": updatedAt.millisecondsSinceEpoch,
      "isLive": isLive,
    };
  }

  SongModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    title = data["title"];
    city = data["city"];
    genre = data["genre"];
    posterUrl = data["posterUrl"];
    songUrl = data["songUrl"];
    bandId = data["bandId"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(data["createdAt"]);
    updatedAt = DateTime.fromMillisecondsSinceEpoch(data["updatedAt"]);
    isLive = data["isLive"] ?? false;
  }
}
