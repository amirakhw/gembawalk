import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/core/models/form.dart';
import 'package:gembawalk_front/core/models/rubrique.dart';
import 'package:gembawalk_front/core/service/form_api_service.dart';

import '../core/models/visit.dart';

class LocalDB extends ChangeNotifier {
  //  liste de visit<rubriques<rubrique_id , checklist_item>>
  final List<Visit> _allData = [];
  late Future<FormModel> _form;

  List<Visit> get localDB => _allData;

  LocalDB() {
    _form = FormApiService(
      baseUrl: 'http://' + dotenv.get('LOCALIP') + ':8080/api',
    ).fetchForm(1);
  }

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

    Visit visit = Visit(
      id: _allData.length,
      agence_id: agenceId,
      created_at: DateTime.now(),
      rubriques: _reponse,
    );

    _allData.add(visit);

    print("--------------------${_allData.length}");
    notifyListeners();
  }
}
