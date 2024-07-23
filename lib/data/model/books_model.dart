import 'courses_model.dart';

class BooksModel {
  int? id;
  String? name;
  String? imageUrl;
  String? color;
  String? description;
  String? level;
  String? kursbuch;
  String? arbeitsbuch;
  String? kursbuchAntwortblatt;
  String? arbeitsbuchAntwortblatt;
  String? game;
  List<CoursesModel>? courses;

  BooksModel({this.id, this.name, this.imageUrl, this.color, this.courses});

  BooksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    color = json['color'];
    level = json['level'];
    kursbuch = json['kursbuch'];
    arbeitsbuch = json['arbeitsbuch'];
    kursbuchAntwortblatt = json['kursbuchAn'];
    arbeitsbuchAntwortblatt = json['arbeitsbuchAn'];
    game = json['game'];
    description = json['description'] ?? '';
    if (json['courses'] != null) {
      courses = <CoursesModel>[];
      json['courses'].forEach((v) {
        courses!.add(CoursesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['color'] = color;
    data['description'] = description;
    data['level'] = level;
    data['kursbuch'] = kursbuch;
    data['arbeitsbuch'] = arbeitsbuch;
    data['kursbuchAn'] = kursbuchAntwortblatt;
    data['arbeitsbuchAn'] = arbeitsbuchAntwortblatt;
    data['game'] = game;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
