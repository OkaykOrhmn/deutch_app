import 'package:dio/dio.dart';

import '../api/dio_helper.dart';

final downloadRepository = DownloadRepository(DioHelper());
final CancelToken downloadCancelToken = CancelToken();

class DownloadRepository implements Download {
  final DioHelper dioHelper;

  DownloadRepository(this.dioHelper);

  @override
  Future<Response> getMedia(
      String url, String path, Function(int, int)? progress) async {
    // try {
    final response = await dioHelper.sendRequest.download(url, path,
        cancelToken: downloadCancelToken,
        deleteOnError: true,
        onReceiveProgress: progress);
    return response;
    // } catch (e) {
    //   rethrow;
    // }
  }
}

abstract class Download {
  Future<Response> getMedia(
      String url, String path, Function(int, int)? progress);
}
