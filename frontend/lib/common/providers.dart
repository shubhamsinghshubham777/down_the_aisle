import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/utils/extensions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) {
  return SharedPreferences.getInstance();
}

@riverpod
String baseUrl(BaseUrlRef ref) {
  final baseUrl = dotenv.env['BASE_URL'];
  if (baseUrl == null) {
    throw Exception('BASE_URL not found in environment variables!');
  }
  return baseUrl;
}

@riverpod
Dio dio(DioRef ref) {
  return Dio(
    BaseOptions(baseUrl: ref.watch(baseUrlProvider)),
  )..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sharedPrefs = await ref.read(sharedPreferencesProvider.future);
          handler.next(
            options
              ..headers['Authorization'] = 'Bearer ${sharedPrefs.accessToken}',
          );
        },
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    ]);
}
