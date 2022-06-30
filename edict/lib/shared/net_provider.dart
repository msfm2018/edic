import 'package:dio/dio.dart';

const ip = '192.168.3.32:9011';

class NetProvider {
  var options = BaseOptions(
    baseUrl: 'http://$ip',
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
