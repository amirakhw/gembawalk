import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/form.dart';

class FormApiService {
  final String baseUrl;

  FormApiService({required this.baseUrl});

  Future<FormModel> fetchForm(int formId) async {
    final url = Uri.parse('$baseUrl/forms/$formId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return FormModel.fromJson(jsonBody);
    } else {
      throw Exception('Échec du chargement du formulaire (code: ${response.statusCode})');
    }
  }
}
