import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:gembawalk_front/core/models/form.dart';
import 'package:gembawalk_front/core/models/rubrique.dart';

import 'package:gembawalk_front/core/service/form_api_service.dart';
import 'package:gembawalk_front/core/service/planAction_api_service.dart';
import 'package:image_picker/image_picker.dart';

import '../core/models/visit.dart';

class LocalDB extends ChangeNotifier {
  FormApiService formApiService = FormApiService(
    baseUrl: 'http://${dotenv.get('LOCALIP')}:8080/api',
  );
  PlanactionApiService planactionApiService = PlanactionApiService();
  final List<Visit> _allData = [];
  late Future<FormModel> _form;

  List<Visit> get localDB => _allData;

  LocalDB() {
    _form = formApiService.fetchForm(1);
  }

  Future<void> add(data, agenceId) async {
    print(
      "******************** Adding data in all data notifier *************",
    );
    print(data);
    List<Rubrique>? _reponse;
    FormModel formModel = await _form;
    //Create a copy from the rubrique and its responses
    _reponse = formModel.copyRubriqueList();
    // filling the local copy with the user input
    for (var rub in _reponse) {
      if (rub.type == "CHECKLIST") {
        for (var item in rub.checklistItems) {
          item.comment = data[rub.id]?['comments']?['item_${item.id}'];
          item.ticket_number =
              data[rub.id]?['ticketNumbers']?['item_${item.id}'];
          item.status = data[rub.id]?['conformity']?['item_${item.id}'];
          item.images = data[rub.id]?['images']?['item_${item.id}'];
        }
      } else if (rub.type == "QUESTIONS") {
        for (var item in rub.questions) {
          item.responseText = data[rub.id]?["question_${item.id}"];
        }
      }
    }
    // then create a visit from the copy to send it to the db
    Visit visit = Visit(
      id: _allData.length,
      agence_id: agenceId,
      //agence_name: _agence_name,
      created_at: DateTime.now(),
      rubriques: _reponse,
    );

    planactionApiService.postVisit(visit);
    print("------------- image api call --------------------");
    print(
      "------------- ${visit.rubriques[0].checklistItems[0]} --------------------",
    );

    /* planactionApiService.uploadImageToServer(
      visit.rubriques[0].checklistItems[0].images?[0] ?? XFile(""),
    ); */

    for (final rub in visit.rubriques) {
      for (final item in rub.checklistItems) {
        for (final img in item.images ?? []) {
          planactionApiService.uploadImageToServer(img);
        }
      }
    }

    _allData.add(visit);

    print("--------------------${_allData.length}");
    notifyListeners();
  }
}
