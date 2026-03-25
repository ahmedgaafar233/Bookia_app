import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  dio.options.baseUrl = 'https://codingarabic.online/api';
  
  try {
    final response = await dio.post('/add-to-wishlist');
    print('SUCCESS: \${response.statusCode}');
  } on DioException catch (e) {
    print('Dio URL: \${e.requestOptions.uri}');
    print('Dio Status: \${e.response?.statusCode}');
  }
}
