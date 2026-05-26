import 'package:dio/dio.dart';

class JsonplaceholderCustomDio {
  
  final _dio = Dio();

  Dio get dio => _dio;

  JsonplaceholderCustomDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }
}