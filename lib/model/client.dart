class NoteModel {
  String description;
  DateTime date;
  String category;
  int categoryNum;
  int id;
  String dateTime;

  NoteModel({
    this.description,
    this.date,
    this.category,
    this.categoryNum,
    this.id,
    this.dateTime,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      description: json["description"] ?? null,
      date: DateTime.tryParse(json["dateTime"]) ?? null,
      dateTime: json["dateTime"],
      category: json["category"] ?? null,
      categoryNum: json["categoryNum"] ?? null,
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "category": category,
        "categoryNum": categoryNum,
        "id": id,
        "dateTime": dateTime,
      };
}
