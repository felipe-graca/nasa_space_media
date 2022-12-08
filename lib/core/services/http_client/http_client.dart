// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class HttpClient {
  Future<HttpResponse> get(String url);

  Future<HttpResponse> post(String url, {Map<String, dynamic> body});
}

class HttpResponse {
  final dynamic data;
  final int? statusCode;

  HttpResponse({required this.data, this.statusCode});
}
