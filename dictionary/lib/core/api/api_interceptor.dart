import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../injection_container.dart';
import '../utils/toggle_config.dart';

abstract class IHttpClient {
  Future<Response> get(String? endpoint, {Map<String, String>? headers});
  Future<Response> post(String? endpoint, String body, {Map<String, String>? headers});
  Future<Response> patch(String? endpoint, String body, {Map<String, String>? headers});
  Future<Response> put(String? endpoint, String body, {Map<String, String>? headers});
  Future<Response> delete(String? endpoint, {Map<String, String>? headers});
}

class HttpClient extends IHttpClient implements InterceptorContract {
  late InterceptedClient _client;
  final toggleConfig = sl<IToggleConfig>();

  HttpClient() {
    _client = InterceptedClient.build(interceptors: [this]);
  }
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers['Content-Type'] = 'application/json';
    data.headers['X-RapidAPI-Key'] = toggleConfig.getString('rapid_api_key');
    data.headers['X-RapidAPI-Host'] = toggleConfig.getString('rapid_api_host');

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response ${data.url}');
    debugPrint('status code: ${data.statusCode}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    debugPrint('body: $data');
    return data;
  }

  @override
  Future<Response> delete(String? endpoint, {Map<String, String>? headers}) async {
    final response = await _client.delete(
      endpoint!.toUri(),
      headers: headers,
    );
    return response;
  }

  @override
  Future<Response> get(String? endpoint, {Map<String, String>? headers}) async {
    final response = await _client.get(
      endpoint!.toUri(),
      headers: headers,
    );
    return response;
  }

  @override
  Future<Response> patch(String? endpoint, String body, {Map<String, String>? headers}) async {
    final response = await _client.patch(
      endpoint!.toUri(),
      body: body,
      headers: headers,
    );
    return response;
  }

  @override
  Future<Response> post(String? endpoint, String body, {Map<String, String>? headers}) async {
    final response = await _client.post(
      endpoint!.toUri(),
      body: body,
      headers: headers,
    );
    return response;
  }

  @override
  Future<Response> put(String? endpoint, String body, {Map<String, String>? headers}) async {
    final response = await _client.put(
      endpoint!.toUri(),
      body: body,
      headers: headers,
    );
    return response;
  }
}
