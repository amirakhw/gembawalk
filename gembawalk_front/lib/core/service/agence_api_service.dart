import 'dart:convert';
import 'package:gembawalk_front/core/models/agence.dart';
import 'package:http/http.dart' as http;

class AgenceApiService {
  final String baseUrl;

  AgenceApiService({required this.baseUrl});

  Future<AgenceModel> fetchAgence() async {
    final url = Uri.parse('$baseUrl/agencies/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return AgenceModel.fromJson(jsonBody);
    } else {
      throw Exception(
        'Échec du chargement du agences (code: ${response.statusCode})',
      );
    }
  }
}
