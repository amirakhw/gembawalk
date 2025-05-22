import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:gembawalk_front/core/models/form.dart';
import 'package:gembawalk_front/core/models/rubrique.dart';

import 'package:gembawalk_front/core/service/form_api_service.dart';
import 'package:gembawalk_front/core/service/planAction_api_service.dart';

import '../core/models/visit.dart';

class LocalDB extends ChangeNotifier {
  FormApiService formApiService = FormApiService(
    baseUrl: 'http://${dotenv.get('LOCALIP')}:8080/api',
  );
  PlanactionApiService planactionApiService = PlanactionApiService();
  //  liste de visit<rubriques<rubrique_id , checklist_item>>
  final List<Visit> _allData = [];
  late Future<FormModel> _form;
  //late List<Future<AgenceModel>> _agences;
  //late String _agence_name;

  List<Visit> get localDB => _allData;

  LocalDB() {
    _form = formApiService.fetchForm(1);
    //_agences = AgenceApiService(baseUrl: 'http://' + dotenv.get('LOCALIP') + ':8080/api').fetchAgence();
  }

  /* Future<void> _fetchAgencies() async {
    final response = await http.get(
      Uri.parse('http://' + dotenv.get('LOCALIP') + ':8080/api/agencies/all'),
    );
    if (response.statusCode == 200) {
      print(
        "*****************json agency **************************** \n $_agences",
      );
      _agences = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      print('Erreur lors du chargement des agences.');
    }
  } */

  Future<void> add(data, agenceId) async {
    print(
      "******************** Adding data in all data notifier *************",
    );
    List<Rubrique>? _reponse;
    FormModel formModel = await _form;

    _reponse = formModel.copyRubriqueList();

    for (var rub in _reponse) {
      for (var item in rub.checklistItems) {
        item.comment = data[rub.id]?['comments']?['item_${item.id}'];
        item.ticket_number = data[rub.id]?['ticketNumbers']?['item_${item.id}'];
        item.status = data[rub.id]?['conformity']?['item_${item.id}'];
      }
    }

    /* for (var ag in agList) {
      print("************************ $ag ************************");
      if (ag["id"] == agenceId) {
        _agence_name = ag["name"];
      }
    } */

    Visit visit = Visit(
      id: _allData.length,
      agence_id: agenceId,
      //agence_name: _agence_name,
      created_at: DateTime.now(),
      rubriques: _reponse,
    );

    planactionApiService.postVisit(visit);

    _allData.add(visit);

    print("--------------------${_allData.length}");
    notifyListeners();
  }
}
