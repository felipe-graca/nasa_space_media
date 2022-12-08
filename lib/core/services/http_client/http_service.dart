import 'package:nasa_clean_arch/core/services/http_client/http_service_interface.dart';
import 'package:http/http.dart' as http;

class HttpServer implements IHttpService {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(Uri.parse(url));

    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }
}
