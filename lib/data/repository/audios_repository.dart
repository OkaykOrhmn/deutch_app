import 'package:deutch_app/data/api/api_endpoints.dart';
import 'package:deutch_app/data/api/dio_helper.dart';
import 'package:deutch_app/data/model/audios_model.dart';
import 'package:dio/dio.dart';

final audiosRepository = AudiosRepository(DioHelper());

class AudiosRepository implements Audioss {
  final DioHelper dioHelper;
  AudiosRepository(this.dioHelper);

  @override
  Future<AudiosModel> getAllAudios(
      {required final int bookId,
      required final int courseId,
      required final String url}) async {
    try {
      Response response = await dioHelper.sendRequest.post(
          "${ApiEndPoints.baseURL}${ApiEndPoints.books}/$bookId${ApiEndPoints.courses}/$courseId${ApiEndPoints.audios}",
          data: {"url": url});
      return AudiosModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Audioss {
  Future<AudiosModel> getAllAudios(
      {required final int bookId,
      required final int courseId,
      required final String url});
}
