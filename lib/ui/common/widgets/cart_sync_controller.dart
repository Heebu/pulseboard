import 'package:flutter/material.dart';

class ChartSyncController extends ChangeNotifier {
  DateTime? _hoverDate;

  DateTime? get hoverDate => _hoverDate;

  void setHoverDate(DateTime? date) {
    _hoverDate = date;
    notifyListeners();
  }

  void clearHover() {
    _hoverDate = null;
    notifyListeners();
  }
}
