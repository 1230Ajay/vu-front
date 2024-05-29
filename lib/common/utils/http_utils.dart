import 'package:dio/dio.dart';
import 'package:vu/common/values/constant.dart';
import 'package:vu/global.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  static Future<HttpUtil> create() async {
    final httpUtil = HttpUtil._internal();
    await httpUtil._initialize();
    return httpUtil;
  }

  Future _initialize() async {
    updateHeaders();
  }

  void updateHeaders() {

    String? token = Global.storageService.getUserAccessToken();
    if(token!=null){
      dio.options.headers["Authorization"] = "Bearer ${token}";
    }else{
      print("token is being null");
    }
  }

  HttpUtil._internal() {

    BaseOptions options = BaseOptions(
      baseUrl:"${AppConstants.BASE_URL}/",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      contentType: 'application/json',
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status! < 500; // Return true if the status code is less than 500
      },
    );

    dio = Dio(options);

  }

  Future<Response> refreshToken() async {
    final refreshEndpoint = "auth/refresh/";
    final refreshToken = Global.storageService.getUserRefreshToken();

    try {
      // Make a POST request to refresh the token
      final response = await dio.post(
        refreshEndpoint,
        data: {"refresh": refreshToken},
      );

      // If the refresh is successful, update the access token
      final newAccessToken = response.data["access"];
      final newRefreshToken = response.data["refresh"];
      await Global.storageService.setUserToken(newAccessToken);
      await Global.storageService.setUserRefreshToken(newRefreshToken);

      // Update headers to include the new access token
      updateHeaders();

      // Return the original response
      return response;
    } catch (e) {
      // Handle DioError specifically
      print("An Error has occured.......................");

      // Re-throw the exception for other cases
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {

    try{
      updateHeaders();
    }catch(e){
      print("An error has occured to post request : $e");
    }

    try {


      // Make the original POST request
      final response = await dio.post(path, data: data, queryParameters: queryParameters);

      if (response.statusCode == 401) {
        // If the response status is 401, attempt to refresh the token
        await refreshToken();

        // Retry the original request with the updated token
        final retryResponse = await dio.post(path, data: data, queryParameters: queryParameters);
        return retryResponse;
      }

      // Return the original response
      return response;
    } on DioError catch (e) {
      // Handle DioError specifically
      if (e.response?.statusCode == 401) {
        // Token is still not valid after refresh, handle this case (e.g., log the user out)
        print("Token is still not valid after refresh: ${e.message}");
      }

      // Re-throw the exception for other cases
      rethrow;
    }
  }


  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Make the original GET request
      updateHeaders();
      print("User Access Token  : ${Global.storageService.getUserAccessToken()}");

      final response = await dio.get(path, queryParameters: queryParameters);

      if (response.statusCode == 401) {
        // If the response status is 401, attempt to refresh the token
        // await refreshToken();

        // Retry the original request with the updated token
        final retryResponse = await dio.get(path, queryParameters: queryParameters);
        return retryResponse;
      }

      // Return the original response
      return response;
    } on DioError catch (e) {
      // Handle DioError specifically
      if (e.response?.statusCode == 401) {
        // Token is still not valid after refresh, handle this case (e.g., log the user out)
        print("Token is still not valid after refresh: ${e.message}");
      }

      // Re-throw the exception for other cases
      rethrow;
    }
  }

  Future<Response> auth({ required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,}) async {

    try {

      final response = await dio.post(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
     print("error is occured for authentication creation or authenticate : $e");
      rethrow;
    }
  }

}
