// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<TodoNetwork> todoFromJson(String str) {
  final list = jsonDecode(str) as List<dynamic>;

  // Pick the first index and check if there is data or not
  final responseMap = list[0] as Map<String, dynamic>;

  // If body contains doc mean response has some data
  if (responseMap.containsKey('document')) {
    return List<TodoNetwork>.from(
        json.decode(str).map((x) => TodoNetwork.fromJson(x)));
  } else {
    // if not mean there no data found
    // return empty list
    return [];
  }
}

String todoToJson(List<TodoNetwork> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoNetwork extends Equatable {
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

  @override
  List<Object?> get props => [document, readTime];
}

class Document extends Equatable {
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

  @override
  List<Object?> get props => [name, fields, createTime, updateTime];
}

class Fields extends Equatable {
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
        "fields": {
          "date": date.toJson(),
          "isCompleted": isCompleted.toJson(),
          "categoryId": categoryId.toJson(),
          if (id != null) "id": id?.toJson(),
          "name": name.toJson(),
        }
      };

  @override
  List<Object?> get props => [date, isCompleted, categoryId, id, name];
}

class CategoryId extends Equatable {
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

  @override
  List<Object> get props => [stringValue];
}

class IsCompleted extends Equatable {
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

  @override
  List<Object?> get props => [booleanValue];
}
