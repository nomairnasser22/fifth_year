import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fifthproject/core/classes/stutesrequest.dart';
import 'package:fifthproject/core/function/checkinternet.dart';
import 'package:fifthproject/core/model/productmodel.dart';
import 'package:fifthproject/core/model/token_login.dart';
import 'package:fifthproject/core/model/tokenmodel.dart';
import 'package:fifthproject/keys_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dartz/dartz.dart';

class ApiClient {
  GetStorage getStorage = GetStorage();
  final Dio _dio = Dio();

  // ApiClient() {
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     // onRequest: (options, handler) async {
  //     //   print(
  //     //       "  I\'m new in ApiClient constructor and specified in onRequest methos");
  //     //   options.headers["Accept"] = "application/json";
  //     //   String? token = getStorage.read(KeysStorage.accessLogin);
  //     //   options.headers["Authorization"] = "Bearer ${token!}";
  //     //   print(" for now i will go out from onRequest method ");
  //     //   return handler.next(options);
  //     // },
  //     onError: (error, handler) async {
  //       print("I\'m now specified in onError methos");
  //       if (error.response?.statusCode == 401) {
  //         print('i will go to get new access token ');
  //         final newAccessToken = await refreshToken();
  //         if (newAccessToken != null) {
  //           _dio.options.headers["Authorization"] =
  //               "Bearer ${getStorage.read(KeysStorage.accessLogin)}";

  //           print("I'm ready to go out from onError method");
  //           return handler.resolve(await _dio.fetch(error.requestOptions));
  //         }
  //       }
  //       return handler.next(error);
  //     },
  //   ));
  // }

  Future<String> refreshToken() async {
    print("I'm now in refresh token method and i will go to get access");
    final String refresh = getStorage.read(KeysStorage.refreshLogin);
    print("the refresh token is ${refresh}");
    final response = await _dio.post(
        "https://jacoubakizi.pythonanywhere.com/auth/token/refresh/",
        data: {"refresh": refresh});
    print(
        "if you can see me now i get access token and i will come back with it ");
    final tokenAccess = response.data["access"];
    final tokenRefresh = response.data["refresh"];
    getStorage.write(KeysStorage.accessLogin, tokenAccess);
    getStorage.write(KeysStorage.refreshLogin, tokenRefresh);
    print("the new refresh token is ${tokenRefresh}");
    print("the new access token is ${tokenAccess}");
    return tokenAccess;
  }

  Future<Either<TokeModel, StatusRequest>> registerUser(
      Map<String, dynamic>? userData) async {
    if (await CheckInternet()) {
      print("now i enter to registerUser method");
      // try {
      Response response = await _dio.post(
          'https://jacoubakizi.pythonanywhere.com/auth/sign-up/',
          data: userData,
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            "if you see me , you must know that the post method is called and i wil print the date response ${response.data} ");
        return Left(tokeModelFromJson(response.toString()));
      } else {
        return Right(StatusRequest.serverfailure);
      }
      // }
      // on DioError catch (e) {
      //   print(
      //       "if you see me , you must know that the post method is called and i wil print the date response ${e.response!.data} ");
      //   return e.response!.data;
      // }
    } else {
      return Right(StatusRequest.offlinefailure);
    }
  }

  Future<Either<Tokenlogin, StatusRequest>> login(
      Map<String, dynamic>? userData) async {
    if (await CheckInternet()) {
      print("now i enter to login method");
      // try {
      Response response = await _dio.post(
          'https://jacoubakizi.pythonanywhere.com/auth/log-in/?',
          data: userData,
          options: Options(contentType: 'application/json'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            "if you see me , you must know that the post method is called and i wil print the date response ${response.data} ");
        return Left(tokenloginFromJson(response.toString()));
      } else {
        return Right(StatusRequest.serverfailure);
      }

      // } on DioError catch (e) {
      //   return e.response!.data;
      // }
    } else {
      return Right(StatusRequest.offlinefailure);
    }
  }

  Future<dynamic> getPieChart() async {
    try {
      print("I neter to getPieChart method ");
      print("the token is ${getStorage.read(KeysStorage.accessLogin)}");
      Response response = await _dio.get(
          "https://jacoubakizi.pythonanywhere.com/charts/pie-chart/2024",
          options: Options(headers: {
            "Authorization":
                "Bearer ${getStorage.read(KeysStorage.accessLogin)}"
          }));
                getStorage.write(KeysStorage.piecharData, json.encode(response.data));

      print("the token is ${getStorage.read(KeysStorage.accessLogin)}");

      print(
          "I finished for get method and the response is ${json.encode(response.data)}");
      return response.data;
    } catch (e) {
      print("the error is ${e}");
    }
  }

  Future<Either<ProductModel, StatusRequest>> createProduct(
      Map<String, dynamic>? userData) async {
    if (await CheckInternet()) {
      print("now i enter to create product method");
      // try {
      Response response = await _dio.post(
          'https://jacoubakizi.pythonanywhere.com/charts/create-item/',
          data: userData,
          options: Options(contentType: "application/json", headers: {
            "Authorization":
                "Bearer ${getStorage.read(KeysStorage.accessLogin)}"
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            "if you see me , you must know that the post method is called and i wil print the date response ${response.data} ");
        return Left(productModelFromJson(response.toString()));
      } else {
        return Right(StatusRequest.serverfailure);
      }
    } else {
      return Right(StatusRequest.offlinefailure);
    }
  }

  Future<dynamic> getExpenses() async {
    try {
      print("I'm in getExpenses method ");
      String token = getStorage.read(KeysStorage.accessLogin);
      print("the token is ${token})}");
      Response response = await _dio.get(
          "https://jacoubakizi.pythonanywhere.com/charts/create-item/",
          options: Options(contentType: "application/json", headers: {
            "Authorization":
                "Bearer ${getStorage.read(KeysStorage.accessLogin)}"
          })
          // options: Options(headers: {"Authorization": "Bearer ${token}"})
          );
      print(
          "I finished for get method and the response is ${json.encode(response.data)}");
      getStorage.write(KeysStorage.expensesData, json.encode(response.data));
      print(
          "from locale storage : ${getStorage.read(KeysStorage.expensesData)}");
      return response.data;
    } catch (e) {
      print("Error :  ${e}");
    }
  }
}
