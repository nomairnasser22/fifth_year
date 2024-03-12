import 'package:dio/dio.dart';
import 'package:fifthproject/core/model/token_login.dart';
import 'package:fifthproject/core/model/tokenmodel.dart';
import 'package:fifthproject/keys_storage.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient {
  GetStorage getStorage = GetStorage();
  final Dio _dio = Dio();
  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        print(
            "  I\'m new in ApiClient constructor and specified in onRequest methos");
        options.headers["Accept"] = "application/json";
        String? token = getStorage.read(KeysStorage.accessLogin);
        options.headers["Authorization"] = "Bearer ${token!}";
        print(" for now i will go out from onRequest method ");
        return handler.next(options);
      },
      onError: (error, handler) async {
        print(
            "  I\'m new in ApiClient constructor and specified in onError methos");
        if (error.response?.statusCode == 401) {
          print('i will go to get new access token ');
          final newAccessToken = await refreshToken();
          if (newAccessToken != null) {
            _dio.options.headers["Authorization"] = "bearer ${newAccessToken}";
            ;
            print("I'm really to go out from onError method");
            return handler.resolve(await _dio.fetch(error.requestOptions));
          }
        }
      },
    ));
  }

  Future<String> refreshToken() async {
    print("I'm now in refresh token method and i will go to get access");
    final String refresh = getStorage.read(KeysStorage.refreshLogin);
    final response = await _dio.post(
        "https://jacoubakizi.pythonanywhere.com/auth/token/refresh/",
        data: {"refresh": refresh});
    print(
        "if you can see me now i get access token and i will come back with it ");
    final tokenAccess = response.data["access"];
    getStorage.write(KeysStorage.accessLogin, tokenAccess);
    return tokenAccess;
  }

  Future<TokeModel> registerUser(Map<String, dynamic>? userData) async {
    print("now i enter to registerUser method");
    // try {
    Response response =
        await _dio.post('https://jacoubakizi.pythonanywhere.com/auth/sign-up/',
            data: userData,
            // queryParameters: {'apikey': 'YOUR_API_KEY'}, //QUERY PARAMETERS
            options: Options(contentType: "application/json"
                //   headers: {
                //   'X-LoginRadius-Sott': 'YOUR_SOTT_KEY', //HEADERS
                // }
                ));
    print(
        "if you see me , you must know that the post method is called and i wil print the date response ${response.data} ");
    return tokeModelFromJson(response.toString());
    // }
    // on DioError catch (e) {
    //   print(
    //       "if you see me , you must know that the post method is called and i wil print the date response ${e.response!.data} ");
    //   return e.response!.data;
    // }
  }

  Future<Tokenlogin> login(Map<String, dynamic>? userData) async {
    print("now i enter to login method");
    // try {
    Response response = await _dio.post(
        'https://jacoubakizi.pythonanywhere.com/auth/log-in/?',
        data: userData,
        options: Options(contentType: 'application/json'));
    print("the data is ${response.data}");
    return tokenloginFromJson(response.toString());
    // } on DioError catch (e) {
    //   return e.response!.data;
    // }
  }
}
