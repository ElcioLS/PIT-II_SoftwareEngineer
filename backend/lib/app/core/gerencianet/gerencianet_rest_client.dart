import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
// import 'package:dio/native_imp.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dotenv/dotenv.dart';

import 'gerencianet_auth_interceptor.dart';

// var env = DotEnv(includePlatformEnvironment: true)..load();

class GerencianetRestClient extends DioForNative {
  static final _baseOptions = BaseOptions(
    baseUrl: env['GERENCIANET_URL'] ?? env['gerencianetURL'] ?? '',
    connectTimeout: Duration(milliseconds: 60000),
    receiveTimeout: Duration(milliseconds: 60000),
  );

  GerencianetRestClient() : super(_baseOptions) {
    _configureCertificates();
    interceptors.add(LogInterceptor(responseBody: true));
  }

  GerencianetRestClient auth() {
    interceptors.add(GerencianetAuthInterceptor());
    return this;
  }

  void _configureCertificates() {
    httpClientAdapter =
        Http2Adapter(ConnectionManager(onClientCreate: (uri, config) {
      final pathCRT = env['GERENCIANET_CERTIFICADO_CRT'] ??
          env['gerencianetCertificadoCRT'] ??
          '';
      final pathKEY = env['GERENCIANET_CERTIFICADO_KEY'] ??
          env['gerencianetCertificadoKEY'] ??
          '';

      final root = Directory.current.path;
      final securityContext = SecurityContext(withTrustedRoots: true);
      securityContext.useCertificateChain('$root/$pathCRT');
      securityContext.usePrivateKey('$root/$pathKEY');
      config.context = securityContext;
    }));
  }
}
