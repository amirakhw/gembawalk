import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';
import 'package:gembawalk_front/core/models/visit.dart';
import 'package:http/http.dart' as http;

//(json['rubriques'] as List).map((r) => Rubrique.fromJson(r)).toList()

class PlanactionApiService {
  Future<List<ChecklistItemReponseModel>> fetchChecklistResponse(
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

    final body = visit.toJson(formId: 1, userId: 2);

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

  Future<void> postResolveStatus(int responseId, bool resolved) async {
    final url = Uri.parse(
      'http://${dotenv.get('LOCALIP')}:8080/api/checklist/resolve',
    );

    final body = {'responseId': responseId, 'resolved': resolved};

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print(' Response marked as resolved');
      } else {
        print(' Failed to mark as resolved: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print(' Error while marking as resolved: $e');
    }
  }

  Future<void> postConfirmStatus(int responseId, bool confirmed) async {
    // 1. Builds the backend URL: http://<your_local_ip>:8080/api/checklist/confirm
    final url = Uri.parse(
      'http://${dotenv.get('LOCALIP')}:8080/api/checklist/confirm',
    );

    // 2. Prepares a body with responseId and confirmed
    final body = {'responseId': responseId, 'confirmed': confirmed};

    try {
      // 3. Sends a POST request to the backend with this body
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // 4. If the backend replies with success (200 or 204), it prints success
      if (response.statusCode == 200) {
        print(' Response confirmed');
      }
      // 5. If the backend fails, it prints an error message
      else {
        print(' Failed to confirm: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      // 5. (continued) If a connection error or unexpected error occurs
      print(' Error while confirming response: $e');
    }
  }

  Future<void> terminate(int visitId) async {
    // 1. Builds the backend URL: http://<your_local_ip>:8080/api/checklist/confirm
    final url = Uri.parse(
      'http://${dotenv.get('LOCALIP')}:8080/api/visits/terminate/${visitId}',
    );

    try {
      // 3. Sends a POST request to the backend with this body
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),
      );

      // 4. If the backend replies with success (200 or 204), it prints success
      if (response.statusCode == 200) {
        print(' Response confirmed');
      }
      // 5. If the backend fails, it prints an error message
      else {
        print(' Failed to confirm: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      // 5. (continued) If a connection error or unexpected error occurs
      print(' Error while confirming response: $e');
    }
  }

  Future<List<ChecklistItemReponseModel>> getVisitHistoryDetails(
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
}
