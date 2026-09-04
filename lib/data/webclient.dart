import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class WebClient {
  final Map<String, String>? customHeader;
  final String? host;
  final String? apiPrefix;

  const WebClient({
    this.customHeader,
    this.host,
    this.apiPrefix
  });

  factory WebClient.userApi(String? currentUserToken) {
    return WebClient(
      host: 'api.thecatapi.com',
      apiPrefix: 'v1',
      customHeader: {
        'api_key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr',
      }
    );
  }

  Future<List<dynamic>> get(String path) async {
    final http.Response response = await IOClient(HttpClient()..badCertificateCallback = (_, __, ___) => true)
      .get(_buildUrl(path), headers: _buildHeaders());

    _handleHttpError(response);

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data) async {
    final http.Response response = await IOClient(HttpClient()..badCertificateCallback = (_, __, ___) => true)
      .post(_buildUrl(path),
        body: json.encode(data),
        headers: _buildHeaders(),
      );

    _handleHttpError(response);

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> put(String path, dynamic data) async {
    final http.Response response = await IOClient(HttpClient()..badCertificateCallback = (_, __, ___) => true)
      .put(_buildUrl(path),
        body: json.encode(data),
        headers: _buildHeaders(),
      );

    _handleHttpError(response);

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Uri _buildUrl(String path) {
    final uri = Uri(
      scheme: 'https',
      host: host,
      path: '$apiPrefix$path'
    );

    return uri;
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json; charset=utf-8',
    }..addAll(customHeader ?? {});
  }

  void _handleHttpError(http.Response response) {
    if (response.statusCode == 401) throw ServerError(response);
    else if (response.statusCode >= 400) throw ServerError(response);
  }
}

class ServerError implements Error {
  final http.Response response;

  ServerError(this.response);

  int get statusCode => response.statusCode;

  dynamic get parsedResponse => json.decode(response.body);

  @override
  StackTrace get stackTrace => StackTrace.fromString('Error: ${response.body}');
}