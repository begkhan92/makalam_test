import 'package:dio/dio.dart';
import 'package:makalam_test/model/article_responce.dart';

class ArticleRepository {
  final Dio dio;

  ArticleRepository({required this.dio}) {
    dio.options.headers['X-Firebase-AppCheck'] =
        'eyJraWQiOiJRNmZ5eEEiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxOjczMDk1OTUyOTQ1NTp3ZWI6NjM3ZGEyZTgyNmU1ZGYzMjY0YTIxYSIsImF1ZCI6WyJwcm9qZWN0c1wvNzMwOTU5NTI5NDU1IiwicHJvamVjdHNcL21ha2FsYW0iXSwicHJvdmlkZXIiOiJyZWNhcHRjaGFfZW50ZXJwcmlzZSIsImlzcyI6Imh0dHBzOlwvXC9maXJlYmFzZWFwcGNoZWNrLmdvb2dsZWFwaXMuY29tXC83MzA5NTk1Mjk0NTUiLCJleHAiOjE3MjQ2ODE2OTAsImlhdCI6MTcyNDY3ODA5MCwianRpIjoiamtBMEhIYzBOcWlxVFh1NUh4cVZHd1hKaGpyaFdwMHZNekhKR2kyeGFVdyJ9.g1tUrT7IgqUvFttRlOd6GMSiHxS2JmtBP15jmr8QZTNBXArSRkbYBbxX4ujfkYc-RllBh6cl0f3lRbYK6aYoFh_-0xKnvlIgRPahRXSdDc0b5yHC5f-BiCwKA4t_Nl5xqW4OxzmhpPoBnt7Nwg4ug25rJHlL2xLXAMPCeTjtkxLPdghHYFh3RIOcMZ0P-MURW8WNfK2fLdhfB9NTEvqZkNd6aQyboyJbZGKwGf89jeIXwgqtxyPEW0Ec8pVDIW2O1xncs1LjgZUYvsLcEblqSOvy2MCzexq92-SsWCfELlSGI8MqhSDn1Uni1pZjr8Kt4IHbSCzXPNVm25PkYNU9286JR7oIxQ41Zd_spoWau1Xybt-oA2iBKLEV9_3r5VP9QNBUa2cGUQkJKMEpJG56b9uVq2oJxXh85Ze76z0f5XnieJAFO_MFjJ4uPVFT6clJd3c_iFzli6ufbpaTd3aHSPGSn2Yen-oGDV8dVk_nlbuZ_3aiY7D2dpjVvNRe4AOP';
  }

  Future<ArticleResponse?> fetchListOfArticles({String? url}) async {
    try {
      Response response =
          await dio.get(url ?? 'https://makalam.com/api/articles/');
      if (response.statusCode == 200) {
        return ArticleResponse.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Request failed: $e');
      return null;
    }
  }
}
