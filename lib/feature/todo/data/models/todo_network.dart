// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<TodoNetwork> todoFromJson(String str) => List<TodoNetwork>.from(
    json.decode(str).map((x) => TodoNetwork.fromJson(x)));

String todoToJson(List<TodoNetwork> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoNetwork {
  TodoNetwork({
    required this.document,
    required this.readTime,
  });

  Document document;
  DateTime readTime;

  factory TodoNetwork.fromJson(Map<String, dynamic> json) => TodoNetwork(
        document: Document.fromJson(json["document"]),
        readTime: DateTime.parse(json["readTime"]),
      );

  TodoNetwork copyWith({Document? document, DateTime? readTime}) {
    return TodoNetwork(
      document: document ?? this.document,
      readTime: readTime ?? this.readTime,
    );
  }

  Map<String, dynamic> toJson() => {
        "document": document.toJson(),
        "readTime": readTime.toIso8601String(),
      };
}

class Document {
  Document({
    required this.name,
    required this.fields,
    required this.createTime,
    required this.updateTime,
  });

  String name;
  Fields fields;
  DateTime createTime;
  DateTime updateTime;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        fields: Fields.fromJson(json["fields"]),
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Document copyWith({
    String? name,
    Fields? fields,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Document(
      name: name ?? this.name,
      fields: fields ?? this.fields,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields.toJson(),
        "createTime": createTime.toIso8601String(),
        "updateTime": updateTime.toIso8601String(),
      };
}

class Fields {
  Fields({
    required this.date,
    required this.isCompleted,
    required this.categoryId,
    this.id,
    required this.name,
  });

  CategoryId date;
  IsCompleted isCompleted;
  CategoryId categoryId;
  CategoryId? id;
  CategoryId name;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        date: CategoryId.fromJson(json["date"]),
        isCompleted: IsCompleted.fromJson(json["isCompleted"]),
        categoryId: CategoryId.fromJson(json["categoryId"]),
        id: json["id"] == null ? null : CategoryId.fromJson(json["id"]),
        name: CategoryId.fromJson(json["name"]),
      );

  Fields copyWith({
    IsCompleted? isCompleted,
    CategoryId? id,
    CategoryId? date,
    CategoryId? categoryId,
    CategoryId? name,
  }) {
    return Fields(
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date.toJson(),
        "isCompleted": isCompleted.toJson(),
        "categoryId": categoryId.toJson(),
        "id": id?.toJson(),
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
