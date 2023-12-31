class EventModel {
  String? id;
  late String name;
  late String venue;
  late String description;
  late String posterUrl;
  late DateTime startDate;
  late DateTime endDate;

  late String bandId;
  EventModel({
    this.id,
    required this.description,
    required this.name,
    required this.venue,
    required this.startDate,
    required this.posterUrl,
    required this.bandId,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description":description,
      "venue": venue,
      "posterUrl": posterUrl,
      "bandId" : bandId,
      "startDate": startDate.millisecondsSinceEpoch,
      "endDate": endDate.millisecondsSinceEpoch,
    };
  }
  EventModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    venue = data["venue"];
    bandId = data["bandId"];
    description = data['description'];
    posterUrl = data["posterUrl"];
    startDate = DateTime.fromMillisecondsSinceEpoch(data["startDate"]);
    endDate = DateTime.fromMillisecondsSinceEpoch(data["endDate"]);
  }
}
