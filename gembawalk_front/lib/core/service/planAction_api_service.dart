import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';
import 'package:gembawalk_front/core/models/visit.dart';
import 'package:http/http.dart' as http;
//(json['rubriques'] as List).map((r) => Rubrique.fromJson(r)).toList()

class PlanactionApiService {
  Future<List<ChecklistItemReponseModel>> fetchChecklistRepoonse(
    int visitId,
  ) async {
    final url = Uri.parse(
      'http://${dotenv.get('LOCALIP')}:8080/api/checklist/${visitId}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return (jsonBody as List)
          .map((item) => ChecklistItemReponseModel.fromJson(item))
          .toList();
    } else {
      throw Exception(
        'Échec du chargement du plan d action (code: ${response.statusCode})',
      );
    }
  }

  Future<void> postVisit(Visit visit) async {
    final url = Uri.parse('http://${dotenv.get('LOCALIP')}:8080/api/visits');

    final body = visit.toJson(
      formId: 1, // ✅ replace with actual form ID
      userId: 2, // ✅ replace with actual user ID
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' Visit posted successfully');
      } else {
        print(' Failed to post visit: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print(' Error posting visit: $e');
    }
  }
}
