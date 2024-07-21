class CoursesModel {
  int? id;
  int? bookId;
  String? name;
  int? chapter;
  String? description;
  String? audiosUrl;

  CoursesModel(
      {this.id,
      this.bookId,
      this.name,
      this.chapter,
      this.description,
      this.audiosUrl});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    name = json['name'];
    chapter = json['chapter'];
    description = json['description'];
    audiosUrl = json['audiosUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookId'] = bookId;
    data['name'] = name;
    data['chapter'] = chapter;
    data['description'] = description;
    data['audiosUrl'] = audiosUrl;
    return data;
  }
}
