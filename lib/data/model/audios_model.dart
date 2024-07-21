class AudiosModel {
  List<String>? audios;

  AudiosModel({this.audios});

  AudiosModel.fromJson(Map<String, dynamic> json) {
    audios = json['audios'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['audios'] = audios;
    return data;
  }
}
