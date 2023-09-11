// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class RestClient extends GetConnect {
  // final _backendBaseUrl = 'http://dartweek.academiadoflutter.com.br';
  final _backendBaseUrl = 'http://192.168.0.5:8080';
  // final _backendBaseUrl = 'http://bigburguer.cloudns.nz:8080';

  RestClient() {
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.maxAuthRetries = 3;
    httpClient.baseUrl = _backendBaseUrl;
  }
}

class RestClientException implements Exception {
  final int? code;
  final String message;
  RestClientException(
    this.message, {
    this.code,
  });

  @override
  String toString() => 'RestClientException(code: $code, message: $message)';
}
