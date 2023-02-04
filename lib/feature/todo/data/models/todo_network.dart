class TodoNetwork {
  TodoNetwork({
    required this.documents,
    required this.nextPageToken,
  });

  List<Todos> documents;
  String nextPageToken;

  factory TodoNetwork.fromJson(Map<String, dynamic> json) => TodoNetwork(
        documents:
            List<Todos>.from(json["documents"].map((x) => Todos.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };
}

class Todos {
  Todos({
    required this.name,
    required this.fields,
    required this.createTime,
    required this.updateTime,
  });

  String name;
  Fields fields;
  DateTime createTime;
  DateTime updateTime;

  factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        name: json["name"],
        fields: Fields.fromJson(json["fields"]),
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields.toJson(),
        "createTime": createTime.toIso8601String(),
        "updateTime": updateTime.toIso8601String(),
      };
}

class Fields {
  Fields({
    required this.isCompleted,
    this.id,
    this.date,
    required this.categoryId,
    required this.name,
  });

  IsCompleted isCompleted;
  CategoryId? id;
  Date? date;
  CategoryId categoryId;
  CategoryId name;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isCompleted: IsCompleted.fromJson(json["isCompleted"]),
        id: json["id"] == null ? null : CategoryId.fromJson(json["id"]),
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        categoryId: CategoryId.fromJson(json["categoryId"]),
        name: CategoryId.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "isCompleted": isCompleted.toJson(),
        "id": id?.toJson(),
        "date": date?.toJson(),
        "categoryId": categoryId.toJson(),
        "name": name.toJson(),
      };
}

class CategoryId {
  CategoryId({
    required this.stringValue,
  });

  String stringValue;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class Date {
  Date({
    this.stringValue,
    this.integerValue,
  });

  String? stringValue;
  String? integerValue;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        stringValue: json["stringValue"],
        integerValue: json["integerValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
        "integerValue": integerValue,
      };
}

class IsCompleted {
  IsCompleted({
    required this.booleanValue,
  });

  bool booleanValue;

  factory IsCompleted.fromJson(Map<String, dynamic> json) => IsCompleted(
        booleanValue: json["booleanValue"],
      );

  Map<String, dynamic> toJson() => {
        "booleanValue": booleanValue,
      };
}
