
import 'package:http/http.dart' as http;

Future<http.Response> getAnimeBySearchApi({
  required String query,
}) async {
  final baseUrl = 'https://api.myanimelist.net/v2/anime?q=$query&limit=10';
  try {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'X-MAL-CLIENT-ID': 'c8cc84472c49c56626771bfdffc1554f',
    });

    return response;
  } catch (e) {
    throw Exception("Failed to get data!");
  }
}
