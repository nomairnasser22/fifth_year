import 'package:dio/dio.dart';
import 'package:fifthproject/paths.dart'; 
import '../model/tokenmodel.dart';

class MyApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: "https://jacoubakizi.pythonanywhere.com",
        connectTimeout: const Duration(seconds: 6000),
        receiveTimeout: const Duration(seconds: 6000),
        responseType: ResponseType.json,
        contentType: "application/json"),
  );

  Future<TokeModel> login(Map<String, dynamic> data) async {
    try {
      print("login from api on ");
      final response = await _dio.post(Paths.signup , data: data);
      return tokeModelFromJson(response.toString());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Future.error("invalid credential");
      } else {
        return Future.error("invalid server error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
