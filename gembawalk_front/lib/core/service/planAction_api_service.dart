import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';
import 'package:gembawalk_front/core/models/visit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

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

  //upload image method
  Future<void> uploadImageToServer(XFile imageFile) async {
    final url = Uri.parse(
      'http://${dotenv.get('LOCALIP')}:8080/api/visits/2/images',
    );

    print("* * * * * * * * *  WITH FILE * * * * * * * * * ");
    print(imageFile);

    // Convertir XFile en File
    final file = File(imageFile.path);

    final request = http.MultipartRequest('POST', url);

    // Ajouter l'image au corps de la requête
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', //  Doit être exactement "file" car @RequestParam("file")
        file.path,
        contentType: MediaType('image', 'jpg'),
      ),
    );

    // Envoyer la requête
    final response = await request.send();

    if (response.statusCode == 201) {
      print('Image envoyée avec succès');
    } else {
      print(' Erreur lors de l’envoi : ${response.statusCode}');
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

      if (response.statusCode == 200) {
        print(' Response confirmed');
      } else {
        print(' Failed to confirm: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print(' Error while confirming response: $e');
    }
  }

  Future<void> terminate(int visitId) async {
    final url = Uri.parse(
      'http://${dotenv.get('LOCALIP')}:8080/api/visits/terminate/${visitId}',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        print(' Response confirmed');
      } else {
        print(' Failed to confirm: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
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
