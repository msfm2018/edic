import 'package:dio/dio.dart';

class NetProvider {
  var options = BaseOptions(
    baseUrl: 'http://127.0.0.1:9011',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio? dio;
  NetProvider._() {
    dio = Dio(options);
    _h = this;
  }
  static NetProvider? _h;
  factory NetProvider() {
    return _h ??= NetProvider._();
  }
}
