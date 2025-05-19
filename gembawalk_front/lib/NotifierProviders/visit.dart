import 'package:flutter/material.dart';
import 'package:gembawalk_front/core/models/visit.dart';

class VisitModel extends ChangeNotifier {
  List<Visit> visits = [];

  void add(Visit v) {
    visits.add(v);

    notifyListeners();
  }
}